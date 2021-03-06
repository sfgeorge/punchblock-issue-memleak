## Punchblock mem leak

### Overview
* Occurs with either :asterisk or :native_or_unimrcp output renderers.
* Requires that you are using the suggested adhearsion-asr gem
* Requires an `ask`.  A `say` will not produce the error.
* Does not require playing of any TTS or WAV in the #ask in order for the memory leak to grow.  Our ask command was:  `ask :limit 1`.
* Does not require that the SIPp load test send any DTMF input whatsoever in order for the memory leak to grow.

### Defect details
* Occurs under JRuby as well as C-Ruby.  Rubies and environments tested:
  1. Punchblock `feature/dtmf_recognizer_leak` @ adhearsion/punchblock@afb3c6b
       * [JRuby 1.7.4 environment details](environments/jruby-1.7.4/README.md)
       * [CRuby 1.9.3 environment details](environments/ruby-1.9.3-p392/README.md)
* Breaking change: [Using git-bisect](https://mojolingo.com/blog/2013/using-git-bisect-to-troubleshoot-ruby-gems/), we were able to pin-point this to adhearsion/punchblock@f939eca  
* Latest version tested: Tested and confirmed to still be an issue in Punchblock 2.5.0
* How to reproduce issue:  See [sipp/README.md](sipp/README.md)
* Official issue report: https://github.com/adhearsion/punchblock/issues/217

### Contributors

* [Tony Castiglione](https://github.com/runningferret)
* [Stephen George](https://github.com/sfgeorge)

