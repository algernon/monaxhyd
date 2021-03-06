;; monaxhyd -- Monads for Hy
;; Copyright (c) 2014, 2015 Gergely Nagy <algernon@madhouse-project.org>
;; Heavily based on clojure.algo.monads by Konrad Hinsen and others.
;;
;; The use and distribution terms for this software are covered by the
;; Eclipse Public License 1.0 which can be found in the file
;; EPL-1.0.txt at the root of this distribution. By using this
;; software in any fashion, you are agreeing to be bound by the terms
;; of this license. You must not remove this notice, or any other,
;; from this software.

(require [monaxhyd.core [*]])

(defmonad identity-m
  [m-result (fn [r] r)
   m-bind   (fn [mv f]
              (f mv))])

(defmonad maybe-m
  [m-zero   None
   m-result (fn [v] v)
   m-bind   (fn [mv f]
              (unless (none? mv)
                (f mv)))
   m-plus   (fn [&rest mvs]
              (first (drop-while none? mvs)))])

(defmonad sequence-m
  [m-result (fn [v] [v])
   m-bind   (fn [mv f]
              (flatten (map f mv)))
   m-zero   []
   m-plus   (fn [&rest mvs] (flatten mvs))])
