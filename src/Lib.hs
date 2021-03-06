module Lib
    ( a01_to_a24,
      a25
    ) where

import A01
import A02
import A03
import A04
import A05
import A06
import A07
import A08
import A09
import A10
import A11
import A12
import A13
import A14
import A15
import A16
import A17
import A18
import A19
import A20
import A21
import A22
import A23
import A24
import A25

a01_to_a24 :: IO ()
a01_to_a24 = do
            a01_i <- a01_input
            putStrLn "Day 1:"
            putStrLn $ "Answer 1 : " ++ (show $ a01_ans1 a01_i)
            putStrLn $ "Answer 2 : " ++ (show $ a01_ans2 a01_i)

            a02_i <- a02_input
            putStrLn ""
            putStrLn "Day 2:"
            putStrLn $ "Answer 1 : " ++ (show $ a02_ans1 a02_i)
            putStrLn $ "Answer 2 : " ++ (show $ a02_ans2 a02_i)

            a03_i <- a03_input
            putStrLn ""
            putStrLn "Day 3:"
            putStrLn $ "Answer 1 : " ++ (show $ a03_ans1 a03_i)
            putStrLn $ "Answer 2 : " ++ (show $ a03_ans2 a03_i)

            putStrLn ""
            putStrLn "Day 4:"
            putStrLn $ "Answer 1 : " ++ (show a04_ans1)
            putStrLn $ "Answer 2 : " ++ (show a04_ans2)

            a05_i <- a05_input
            putStrLn ""
            putStrLn "Day 5:"
            putStrLn $ "Answer 1 : " ++ (show $ a05_ans1 a05_i)
            putStrLn $ "Answer 2 : " ++ (show $ a05_ans2 a05_i)

            a06_i <- a06_input
            putStrLn ""
            putStrLn "Day 6:"
            putStrLn $ "Answer 1 : " ++ (show $ a06_ans1 a06_i)
            putStrLn $ "Answer 2 : " ++ (show $ a06_ans2 a06_i)
            
            a07_i <- a07_input
            putStrLn ""
            putStrLn "Day 7:"
            putStrLn $ "Answer 1 : " ++ (show $ a07_ans1 a07_i)
            putStrLn $ "Answer 2 : " ++ (show $ a07_ans2 a07_i)
            
            a08_i <- a08_input
            putStrLn ""
            putStrLn "Day 8:"
            putStrLn $ "Answer 1 : " ++ (show $ a08_ans1 a08_i)
            putStrLn $ "Answer 2 : "
            putStrLn $ a08_ans2 a08_i
            
            a09_i <- a09_input
            putStrLn ""
            putStrLn "Day 9:"
            putStrLn $ "Answer 1 : " ++ (show $ a09_ans1 a09_i)
            putStrLn $ "Answer 2 : " ++ (show $ a09_ans2 a09_i)
            
            a10_i <- a10_input
            putStrLn ""
            putStrLn "Day 10:"
            putStrLn $ "Answer 1 : " ++ (show $ a10_ans1 a10_i)
            putStrLn $ "Answer 2 : " ++ (show $ a10_ans2 a10_i)
            
            a11_i <- a11_input
            putStrLn ""
            putStrLn "Day 11:"
            putStrLn $ "Answer 1 : " ++ (show $ a11_ans1 a11_i)
            putStrLn "Answer 2 : "
            putStrLn $ a11_ans2 a11_i

            putStrLn ""
            putStrLn "Day 12:"
            putStrLn $ "Answer 1 : " ++ (show a12_ans1)
            putStrLn $ "Answer 2 : " ++ (show a12_ans2)

            a13_i <- a13_input
            putStrLn ""
            putStrLn "Day 13:"
            putStrLn $ "Answer 1 : " ++ (show $ a13_ans1 a13_i)
            putStrLn $ "Answer 2 : " ++ (show $ a13_ans2 a13_i)

            a14_i <- a14_input
            putStrLn ""
            putStrLn "Day 14:"
            putStrLn $ "Answer 1 : " ++ (show $ a14_ans1 a14_i)
            putStrLn $ "Answer 2 : " ++ (show $ a14_ans2 a14_i)

            a15_i <- a15_input
            putStrLn ""
            putStrLn "Day 15:"
            putStrLn $ "Answer 1 : " ++ (show $ a15_ans1 a15_i)
            putStrLn $ "Answer 2 : " ++ (show $ a15_ans2 a15_i)

            a16_i <- a16_input
            putStrLn ""
            putStrLn "Day 16:"
            putStrLn $ "Answer 1 : " ++ (show $ a16_ans1 a16_i)
            putStrLn $ "Answer 2 : " ++ (show $ a16_ans2 a16_i)

            a17_i <- a17_input
            putStrLn ""
            putStrLn "Day 17:"
            putStrLn $ "Answer 1 : " ++ (show $ a17_ans1 a17_i)
            putStrLn $ "Answer 2 : " ++ (show $ a17_ans2 a17_i)

            a18_i <- a18_input
            putStrLn ""
            putStrLn "Day 18:"
            putStrLn $ "Answer 1 : " ++ (show $ a18_ans1 a18_i)
            putStrLn $ "Answer 2 : " ++ (show $ a18_ans2 a18_i)

            a19_i <- a19_input
            putStrLn ""
            putStrLn "Day 19:"
            putStrLn $ "Answer 1 : " ++ (show $ a19_ans1 a19_i)
            putStrLn $ "Answer 2 : " ++ (show $ a19_ans2 a19_i)

            a20_i <- a20_input
            putStrLn ""
            putStrLn "Day 20:"
            putStrLn $ "Answer 1 : " ++ (show $ a20_ans1 a20_i)
            putStrLn $ "Answer 2 : " ++ (show $ a20_ans2 a20_i)

            a21_i <- a21_input
            putStrLn ""
            putStrLn "Day 21:"
            putStrLn $ "Answer 1 : " ++ (show $ a21_ans1 a21_i)
            putStrLn $ "Answer 2 : " ++ (show $ a21_ans2 a21_i)

            a22_i <- a22_input
            putStrLn ""
            putStrLn "Day 22:"
            putStrLn $ "Answer 1 : " ++ (show $ a22_ans1 a22_i)
            putStrLn $ "Answer 2 : " ++ (show $ a22_ans2 a22_i)

            a23_i <- a23_input
            putStrLn ""
            putStrLn "Day 23:"
            putStrLn $ "Answer 1 : " ++ (show $ a23_ans1 a23_i)
            putStrLn $ "Answer 2 : " ++ (show $ a23_ans2 a23_i)

            a24_i <- a24_input
            putStrLn ""
            putStrLn "Day 24:"
            putStrLn $ "Answer 1 : " ++ (show $ a24_ans1 a24_i)
            putStrLn $ "Answer 2 : " ++ (show $ a24_ans2 a24_i)
