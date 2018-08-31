(import (clojure.lang DynamicClassLoader))

(let [thread (Thread/currentThread)
      cl (.getContextClassLoader thread)]
  (when-not (instance? DynamicClassLoader cl)
    (.setContextClassLoader thread (DynamicClassLoader. cl))))

(require '[cemerick.pomegranate :refer [add-dependencies]])
(add-dependencies :coordinates '[[org.clojure/tools.nrepl "0.2.13"]
                                 [cider/orchard "0.1.0-SNAPSHOT"]
                                 [cider/cider-nrepl "0.17.0-SNAPSHOT"]]
                  :repositories (merge cemerick.pomegranate.aether/maven-central
                                       {"clojars" "https://clojars.org/repo"}))

(require '[clojure.tools.nrepl.server :as nrepl-server]
         '[cider.nrepl :refer (cider-nrepl-handler)])

(defn rand-range
  "返回指定区间的随机整数"
  [min max]
  (-> (rand-int max)
      (mod (inc (- max min)))
      (+ min)))

(defn gen-port
  "生成一个随机端口，写入 .nrepl-port"
  []
  (let [port (rand-range 10000 65535)
        filename (-> (System/getProperty "user.dir")
                     (clojure.string/trim)
                     (str "/.nrepl-port"))]
    (spit filename  port)
    (println "端口文件已写入" filename)
    port))

(defn start-cider-nrepl-server
  "指定端口启动 cider 的 nrepl server"
  [nrepl-port]
  (nrepl-server/start-server
   :port nrepl-port :handler cider-nrepl-handler))

(def
  ^{:doc "随机端口启动 cider 的 nrepl-server"}
  cider-repl-server
  (let [need-re-start (atom true)]
    (while @need-re-start
      (let [port (gen-port)]
        (try (let [server (start-cider-nrepl-server port)]
               (reset! need-re-start false)
               (println "cider nrepl server started at" port)
               server)
             (catch Exception e))))))
