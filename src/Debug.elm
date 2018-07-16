module Debug exposing
  ( log
  , crash
  , logTime
  )

{-| This library is for investigating bugs or performance problems. It should
*not* be used in production code.

# Debugging
@docs log, crash, logTime
-}

import Native.Debug


{-| Log a tagged value on the developer console, and then return the value.

    1 + log "number" 1        -- equals 2, logs "number: 1"
    length (log "start" [])   -- equals 0, logs "start: []"

Notice that `log` is not a pure function! It should *only* be used for
investigating bugs or performance problems.
-}
log : String -> a -> a
log =
  Native.Debug.log


{-| Crash the program with an error message. This is an uncatchable error,
intended for code that is soon-to-be-implemented. For example, if you are
working with a large ADT and have partially completed a case expression, it may
make sense to do this:

    type Entity = Ship | Fish | Captain | Seagull

    drawEntity entity =
      case entity of
        Ship ->
          ...

        Fish ->
          ...

        _ ->
          Debug.crash "TODO"

The Elm compiler recognizes each `Debug.crash` and when you run into it at
runtime, the error will point to the corresponding module name and line number.
For `case` expressions that ends with a wildcard pattern and a crash, it will
also show the value that snuck through. In our example, that'd be `Captain` or
`Seagull`.

**Use this if** you want to do some testing while you are partway through
writing a function.

**Do not use this if** you want to do some typical try-catch exception handling.
Use the [`Maybe`](Maybe) or [`Result`](Result) libraries instead.
-}
crash : String -> a
crash =
  Native.Debug.crash


{-| Benchmark evaluation time of a function.


This will "wrap" `fn` in a timer and log the eval time in the console.

    logTime "name in console" fn arg

If a function uses multiple args, just put parentheses around all but the last arg.

    logTime "render header" (render arg1 arg2) arg3

On Chrome, this will also be printed in the profiler timeline.
-}
logTime : String -> (a -> b) -> a -> b
logTime =
    Native.Debug.logTime

