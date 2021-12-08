package main

import (
  "fmt"
  "html"
  "go.uber.org/zap"
  "go.uber.org/zap/zapcore"
  "net/http"

)
func initZapLog() *zap.Logger {
  cfg := zap.Config{
    Encoding:         "json",
    Level:            zap.NewAtomicLevelAt(zapcore.DebugLevel),
    OutputPaths:      []string{"stderr"},
    ErrorOutputPaths: []string{"stderr"},
    EncoderConfig: zapcore.EncoderConfig{
      MessageKey: "message",

      LevelKey:    "level",
      EncodeLevel: zapcore.CapitalLevelEncoder,

      TimeKey:    "timestamp",
      EncodeTime: zapcore.ISO8601TimeEncoder,

      CallerKey:    "caller",
      EncodeCaller: zapcore.ShortCallerEncoder,

    },

  }
  logger, _ := cfg.Build()
  return logger

}

func main() {
	loggerMgr := initZapLog()
	zap.ReplaceGlobals(loggerMgr)
	defer loggerMgr.Sync() // flushes buffer, if any
	logger := loggerMgr.Sugar()

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, %q", html.EscapeString(r.URL.Path))
    logger.Infow("received path", "path", html.EscapeString(r.URL.Path))
  })

  http.HandleFunc("/hi", func(w http.ResponseWriter, r *http.Request){
    fmt.Fprintf(w, "Hi")
    logger.Info("received Hi")
  })

  logger.Info("Server started on 8081")
  logger.Fatal(http.ListenAndServe(":8081", nil))
}
