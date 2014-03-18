## JRuby-1.7.4 Environment


### Environment variables

The following environment variables were set for the running ahn (java) process.

    JRUBY_OPTS: -J-Xloggc:/tmp/ahn-gc-log -J-Xmx256m -J-Xms256m --server
    JAVA_HOME: /opt/jdk1.7.0_25


### Gem environment

    $ gem environment
    
    RubyGems Environment:
      - RUBYGEMS VERSION: 1.8.24
      - RUBY VERSION: 1.9.3 (2013-05-16 patchlevel 392) [java]
      - INSTALLATION DIRECTORY: /usr/local/rvm/gems/jruby-1.7.4
      - RUBY EXECUTABLE: /usr/local/rvm/rubies/jruby-1.7.4/bin/jruby
      - EXECUTABLE DIRECTORY: /usr/local/rvm/gems/jruby-1.7.4/bin
      - RUBYGEMS PLATFORMS:
        - ruby
        - universal-java-1.7
      - GEM PATHS:
         - /usr/local/rvm/gems/jruby-1.7.4
         - /usr/local/rvm/gems/jruby-1.7.4@global
      - GEM CONFIGURATION:
         - :update_sources => true
         - :verbose => true
         - :benchmark => false
         - :backtrace => false
         - :bulk_threshold => 1000
         - "install" => "--no-rdoc --no-ri --env-shebang"
         - "update" => "--no-rdoc --no-ri --env-shebang"
      - REMOTE SOURCES:
         - http://rubygems.org/


### Other software dependencies

* rvm: rvm 1.25.14 (stable)
* JRuby: jruby-1.7.4
* Java: jdk1.7.0_25 (server-jre-7u25-linux-x64.gz)
* OS: CentOS release 6.3 (Final) x86_64
* Telephony Platform: Asterisk 1.8.13.0
* Application state
   * Punchblock branch: feature/dtmf_recognizer_leak
   * Punchblock sha1: adhearsion/punchblock@afb3c6b
   * punchblock-issue-memleak sha1: ccb5533


### Monitoring performed

The following tail shows every GC operation (whether fast or full) and any serious ERRORs that may occur during the test.

    tail -F /tmp/ahn-gc-log adhearsion.log | egrep --color 'ERROR|^[0-9]'

