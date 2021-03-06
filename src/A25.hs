{-# LANGUAGE OverloadedStrings #-}

module A25 (a25) where

import Network.Socket
import Network.Socket.ByteString (recv, sendAll)

import Data.ByteString.Char8 (pack,unpack)

import Control.Concurrent (forkFinally)
import qualified Control.Exception as E

import Control.Monad (forever, void)
import Control.Monad.Trans
import Control.Monad.Trans.State.Lazy
import Data.Char (ord,chr)
import qualified Data.Sequence as S

data Op = Add Int Int Int Mode Mode Mode |
          Mult Int Int Int Mode Mode Mode |
          Get Int Mode |
          Put Int Mode |
          JumpIf Int Int Mode Mode |
          JumpIfNot Int Int Mode Mode |
          Less Int Int Int Mode Mode Mode |
          Equals Int Int Int Mode Mode Mode |
          Base Int Mode |
          Stop

data Mode = POS | PAR | REL deriving Show

mode :: Int -> Mode
mode 0 = POS
mode 1 = PAR
mode 2 = REL

op :: Int -> Programme -> Op
op pos (Programme xs)
    | o == 1 = Add p1 p2 p3 m1 m2 m3
    | o == 2 = Mult p1 p2 p3 m1 m2 m3
    | o == 3 = Get p1'' m1
    | o == 4 = Put p1'' m1
    | o == 5 = JumpIf p1' p2' m1 m2
    | o == 6 = JumpIfNot p1' p2' m1 m2
    | o == 7 = Less p1 p2 p3 m1 m2 m3
    | o == 8 = Equals p1 p2 p3 m1 m2 m3
    | o == 9 = Base p1 m1
    | o == 99 = Stop
    | otherwise = error "Unknown op code"
  where
    x = S.index xs pos
    m3 = mode $ x `div` 10000
    m2 = mode $ (x `mod` 10000) `div` 1000
    m1 = mode $ ((x `mod` 10000) `mod` 1000) `div` 100
    o  = (((x `mod` 10000) `mod` 1000) `mod` 100)

    p1 = S.index xs (pos+1)
    p2 = S.index xs (pos+2)
    p3 = S.index xs (pos+3)

    p1' = S.index xs (pos+1)
    p2' = S.index xs (pos+2)

    p1'' = S.index xs (pos+1)

    b i = i /= 0

newtype Programme = Programme { fromProgramme :: S.Seq Int } deriving Show
newtype Buffer    = Buffer { fromBuffer :: [Int] } deriving Show
data Code      = RUN | WAIT | OUT | HALT deriving Show
type ProgState = (Code, Int, Int, Programme, Buffer, Buffer)

appendIBuf :: Int -> State ProgState ()
appendIBuf i = modify (\(x1,x2,x3,x4,Buffer is,x5) -> (x1,x2,x3,x4,Buffer (i:is),x5))

readOBuf :: State ProgState Buffer
readOBuf = do
            (x1,x2,x3,x4,x5,os) <- get
            put (x1,x2,x3,x4,x5,Buffer [])
            return os

eval :: Monad m => StateT ProgState m Buffer
eval =
  do
     (code, ip, bp, prog, istack, ostack) <- get
     case code of
       HALT -> return ostack
       _    -> 
         let o = op ip prog in
         case o of
           Stop ->
             put (HALT, ip, bp, prog, istack, ostack) >> return ostack
           Put a ma ->
             case fromBuffer ostack of
               _        -> put (RUN, ip + 2, bp, prog, istack, Buffer $ look a ma bp prog : fromBuffer ostack) >> eval
           Get a ma ->
             case fromBuffer istack of
               [] -> put (WAIT, ip, bp, prog, istack, ostack) >> return ostack
               (i:is) -> put (RUN, ip + 2, bp, write a ma bp i prog, Buffer is, ostack) >> eval
           Add a b c ma mb mc ->
             put (RUN, ip + 4, bp, write c mc bp (look a ma bp prog + look b mb bp prog) prog, istack, ostack) >> eval
           Mult a b c ma mb mc ->
             put (RUN, ip + 4, bp, write c mc bp (look a ma bp prog * look b mb bp prog) prog, istack, ostack) >> eval
           Less a b c ma mb mc ->
             put (RUN, ip + 4, bp, write c mc bp (i $ look a ma bp prog < look b mb bp prog) prog, istack, ostack) >> eval
           Equals a b c ma mb mc ->
             put (RUN, ip + 4, bp, write c mc bp (i $ look a ma bp prog == look b mb bp prog) prog, istack, ostack) >> eval
           JumpIf a b ma mb ->
             case toB $ look a ma bp prog of
               True -> put (RUN, look b mb bp prog, bp, prog, istack, ostack) >> eval
               False -> put (RUN, ip + 3, bp, prog, istack, ostack) >> eval
           JumpIfNot a b ma mb ->
             case toB $ look a ma bp prog of
               False -> put (RUN, look b mb bp prog, bp, prog, istack, ostack) >> eval
               True -> put (RUN, ip + 3, bp, prog, istack, ostack) >> eval
           Base a ma ->
             put (RUN, ip + 2, bp + look a ma bp prog, prog, istack, ostack) >> eval

  where

    look i mi b (Programme xs) = case mi of
                                   POS -> S.index xs i
                                   PAR -> i
                                   REL -> S.index xs (b + i)

    write i mi b v (Programme xs) = Programme $
                                      case mi of
                                        POS -> S.update i v xs
                                        REL -> S.update (b+i) v xs
                                        PAR -> error "cannot write in parameter mode"

    i False = 0
    i True  = 1
    toB i = i /= 0

splitAt' :: Eq a => a -> [a] -> [[a]]
splitAt' d [] = []
splitAt' d xs = case word of
                  [] -> splitAt' d xs
                  _  -> word : splitAt' d xs'
  where
    (word, xs') = (takeWhile (/= d) xs, dropWhile (==d) $ dropWhile (/= d) xs)

fileName :: String
fileName = "data/a25/input.txt"

convProgramme :: String -> Programme
convProgramme = Programme . S.fromList . fmap read . splitAt' ','

loadProgramme :: String -> IO Programme
loadProgramme = fmap convProgramme . readFile

play :: Socket -> StateT ProgState IO ()
play s =
    do
        Buffer ob <- eval
        let ob' = fmap chr $ reverse ob
        lift $ sendAll s $ pack $ ob'
        msg <- lift $ fmap unpack $ recv s 1024
        let ib = filter (/= 13) $ fmap ord msg
        modify (\(x1,x2,x3,x4,Buffer ib',_) -> (x1,x2,x3,x4,Buffer $ ib' ++ ib,Buffer []))
        play s

a25 :: IO ()
a25 = do
       Programme prog' <- loadProgramme fileName
       let prog = Programme $ prog' S.>< S.replicate 10000 0
       let s0 = (RUN,0,0,prog,Buffer [],Buffer [])

       putStrLn "Game server running. Connect with 'telnet localhost 3000'"
       putStrLn "Close with Ctrl-C"

       runTCPServer Nothing "3000" (\s -> evalStateT (play s) $ s0)

runTCPServer :: Maybe HostName -> ServiceName -> (Socket -> IO a) -> IO a
runTCPServer mhost port server = withSocketsDo $ do
    addr <- resolve
    E.bracket (open addr) close loop
  where
    resolve = do
        let hints = defaultHints {
                addrFlags = [AI_PASSIVE]
              , addrFamily = AF_INET6
              , addrSocketType = Stream
              }
        head <$> getAddrInfo (Just hints) mhost (Just port)
    open addr = do
        sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
        setSocketOption sock ReuseAddr 1
        withFdSocket sock $ setCloseOnExecIfNeeded
        bind sock $ addrAddress addr
        listen sock 1024
        return sock
    loop sock = forever $ do
        (conn, _peer) <- accept sock
        void $ forkFinally (server conn) (const $ gracefulClose conn 5000)
