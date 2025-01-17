(set-logic NIA)

(set-option :produce-models true)
(set-option :incremental true)

; Deklarace promennych pro vstupy
; ===============================

; Parametry
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () Int)
(declare-fun D () Int)
(declare-fun E () Int)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; START OF SOLUTION ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Zde doplnte vase reseni

(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)

(assert
    (and
        (= x (* 2 (* A B)))         ;výpočet x
        (ite
            (< x E) 
            (= y (+ x (* 5 B)))     ;výpočet y pro případ že x < E
            (= y (- x C))           ;výpočet y pro případ že x > E
        )
        (ite
            (> D (+ y 2))
            (= z (- (* x A) (* y B)))   ;výpočet z pro případ že y + 2 < D
            (= z (+ (* x B) (* y A)))   ;výpočet z pro případ že y + 2 > D
        )
        (< z (+ D E))   ;kontrola jestli z < D + E 
        (> D 0)         ;kontrola jestli platí podmínka D > 0
        (> E 0)         ;kontrola jestli platí podmínka D > 0
        (forall ((D2 Int)(E2 Int)(x1 Int) (y1 Int) (z1 Int) )   ;druhé provedení stejných podmínek, aby se splnila podmínka, že součet D + E je nejmenší možný
            (ite    
                (and
                    (= x1 (* 2 (* A B)))                ;x = A * B * 2
                    (ite
                        (< x1 E2) 
                        (= y1 (+ x1 (* 5 B)))           ;y = x + 5 * B
                        (= y1 (- x1 C))                 ;y = x - C
                    )
                    (ite
                        (> D2 (+ y1 2))
                        (= z1 (- (* x1 A) (* y1 B)))    ;z = x * A - y * B
                        (= z1 (+ (* x1 B) (* y1 A)))    ;z = x * B + y * A
                    )
                    (< z1 (+ D2 E2))                    ;z < E + D
                    (> D2 0)
                    (> E2 0)
                )
                (<= (+ D E) (+ D2 E2))  ;kontrola, jestli je součet původních výsledků menší než součet dalších výsledků
                true
            )    
        )
    )
)

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; END OF SOLUTION ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Testovaci vstupy
; ================

(echo "Test 1 - vstup A=1, B=1, C=3")
(echo "a) Ocekavany vystup je sat a D+E se rovna 2")
(check-sat-assuming (
  (= A 1) (= B 1) (= C 3)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 2, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 1) (= B 1) (= C 3) (distinct (+ D E) 2)
))


(echo "Test 2 - vstup A=5, B=2, C=5")
(echo "a) Ocekavany vystup je sat a D+E se rovna 54")
(check-sat-assuming (
  (= A 5) (= B 2) (= C 5)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 54, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 5) (= B 2) (= C 5) (distinct (+ D E) 54)
))

(echo "Test 3 - vstup A=100, B=15, C=1")
(echo "a) Ocekavany vystup je sat a D+E se rovna 253876")
(check-sat-assuming (
  (= A 100) (= B 15) (= C 1)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 253876, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 100) (= B 15) (= C 1) (distinct (+ D E) 253876)
))

(echo "Test 4 - vstup A=5, B=5, C=3")
(echo "a) Ocekavany vystup je sat a D+E se rovna 51")
(check-sat-assuming (
  (= A 5) (= B 5) (= C 3)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 51, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 5) (= B 5) (= C 3) (distinct (+ D E) 51)
))

(echo "Test 5 - vstup A=2, B=1, C=2")
(echo "a) Ocekavany vystup je sat a D+E se rovna 7")
(check-sat-assuming (
  (= A 2) (= B 1) (= C 2)
))
(get-value (D E (+ D E)))
(echo "b) Neexistuje jine reseni nez 7, ocekavany vystup je unsat")
(check-sat-assuming (
  (= A 2) (= B 1) (= C 2) (distinct (+ D E) 7)
))