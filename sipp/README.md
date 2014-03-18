## SIPp load test


### Synopsis

A basic User Agent Client (UAC) load test that hangs up 3 seconds after establish a call with Asterisk/Adhearsion.


### Tips

The SIPp load test performed began "gently" at 1 new call per second.  Over time, the call rate was dynamically increased to 8 calls per second.  Note that the rate that you will be able to safely run is highly dependent (on the power of both the servers of adhearsion and SIPp).  Pushing test calls too hard too fast may cause unrelated errors and invalidate your test.


### Requirements

* SIPp
* Download the The SIPp load test scenario file: [quick_hangup_test_nopcap.xml](quick_hangup_test_nopcap.xml).

_No accompanying .pcap file is necessary, as no media is sent._


### Running

    SIPP_IP_ENDPOINT=Change this to the i.p. of your SIPp server
    ASTERISK_IP_ENDPOINT=Change this to the i.p. of your Asterisk server
    sipp -i $SIPP_IP_ENDPOINT -p 8836 -sf quick_hangup_test_nopcap.xml -l 40 -m 30000 -r 1 -s 4048675309 $ASTERISK_IP_ENDPOINT --trace_err --trace_screen


### Expected Result

* Punchblock should release memory related to calls that have completed
* Punchblock should be able to run the defined load test for at least 48 hours without significant memory increase or performance degradation.

### Actual Result: CRuby

Under CRuby, the virtual memory size of the Adhearsion process continued to grow dramatically, even after a cooling off period to allow all calls to drain.

After running 2 calls and allowing them to drain, the virtual memory size looked like this:

      PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    23258 apptasti  20   0 1639m  56m 3520 S  0.0  0.4   0:01.02 ahn

After 900 calls and draining to 0:

      PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    23258 apptasti  20   0 5835m 198m 3524 S  0.0  1.2   2:35.05 ahn

After 1700 calls and draining to 0:

      PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    23258 apptasti  20   0 7050m 517m 3524 S  0.0  3.2   5:55.56 ahn

### Actual Result: JRuby

Under JRuby, I began seeing Full GCs occur somewhere after 700 calls.  This much is normal...

...But their frequency increases greatly over time.  Additionally, the amount of memory reclaimed by a Full GC operation became less and less over time.  [Because the maximum memory heap size was capped](/environments/jruby-1.7.4/README.md#environment-variables), the system eventually completely failed to accept and operate calls **after roughly 1700 calls**.

Here's a partial snippet from the captured JVM GC log at /tmp/ahn-gc-log:

    ...
    247.027: [GC 254616K->173965K(259712K), 0.0166400 secs]
    248.241: [GC 256525K->175802K(259776K), 0.0168070 secs]
    248.258: [Full GC 175802K->138477K(259776K), 0.8169810 secs]
    249.787: [GC 221101K->141349K(259776K), 0.0155540 secs]
    250.647: [GC 223973K->143809K(257472K), 0.0160920 secs]
    251.909: [GC 224129K->145990K(258624K), 0.0163810 secs]
    253.003: [GC 226310K->147939K(258752K), 0.0158650 secs]
    254.167: [GC 228451K->149687K(258688K), 0.0162880 secs]
    255.305: [GC 230179K->151661K(258816K), 0.0156680 secs]
    256.527: [GC 232301K->153426K(258752K), 0.0177170 secs]
    257.677: [GC 234066K->155283K(258880K), 0.0162310 secs]
    258.893: [GC 236051K->157127K(258816K), 0.0170340 secs]
    260.044: [GC 237895K->159000K(259008K), 0.0160440 secs]
    261.261: [GC 240024K->160809K(258944K), 0.0159690 secs]
    262.409: [GC 241833K->162554K(259072K), 0.0163280 secs]
    263.622: [GC 243706K->164346K(259008K), 0.0171100 secs]
    264.781: [GC 245498K->166195K(259136K), 0.0189670 secs]
    265.985: [GC 247539K->168029K(259136K), 0.0177830 secs]
    267.150: [GC 249373K->169746K(259200K), 0.0169070 secs]
    268.292: [GC 251207K->171651K(259200K), 0.0162340 secs]
    269.507: [GC 253123K->173467K(259328K), 0.0168400 secs]
    270.656: [GC 255122K->175328K(259264K), 0.0169710 secs]
    270.673: [Full GC 175328K->155409K(259264K), 1.3272340 secs]
    272.399: [GC 237073K->158498K(258880K), 0.0117970 secs]
    273.012: [GC 239842K->160787K(259136K), 0.0177480 secs]
    274.244: [GC 242131K->162497K(257856K), 0.0174980 secs]
    275.400: [GC 242561K->164786K(258496K), 0.0181430 secs]
    276.412: [GC 244850K->166432K(257664K), 0.0163130 secs]
    277.547: [GC 245728K->168370K(258112K), 0.0183260 secs]
    278.664: [GC 247666K->170162K(257472K), 0.0166890 secs]
    279.801: [GC 248818K->171712K(257792K), 0.0178650 secs]
    280.927: [GC 250368K->173565K(256256K), 0.0182760 secs]
    282.035: [GC 250685K->175165K(257024K), 0.0173470 secs]
    283.153: [GC 252271K->176703K(253824K), 0.0219650 secs]
    284.233: [GC 250623K->178741K(253568K), 0.0194390 secs]
    284.253: [Full GC 178741K->169657K(253568K), 0.6952330 secs]
    285.578: [GC 243571K->171865K(255360K), 0.0162080 secs]
    286.299: [GC 245593K->173721K(255296K), 0.0178130 secs]
    287.384: [GC 247449K->175225K(254720K), 0.0182100 secs]
    288.391: [GC 248505K->176729K(255104K), 0.0186550 secs]
    289.407: [GC 250009K->178050K(250880K), 0.0212220 secs]
    290.403: [GC 247106K->179635K(251328K), 0.0200220 secs]
    290.424: [Full GC 179635K->175757K(251328K), 0.4881620 secs]
    291.598: [Full GC 244813K->176600K(251328K), 0.4809110 secs]
    292.506: [Full GC 243839K->177400K(251328K), 0.5383820 secs]
    ...



