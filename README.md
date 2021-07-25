<h1>Türsteher</h1>

<h2>About</h2>

Türsteher is a free powerful Windows kernel driver for comprehensive application control, formerly known as executable white- and blacklisting. Türsteher works according to the exclusion principle using an allowlist (formerly known as a whitelist): All explicitly allowed executables run as desired. Türsteher also supports a blocklist (formerly known as a blacklist) where you can specify executables to block. In addition Türsteher supports parent - child rules, so you can specify what executable an application is allowed to start. The driver also supports command line filtering. We used Türsteher to quickly analyze the path of malware infections without need for a sophisticated analysis environment. Türsteher also helped us to examine software issues on big scaled migration projects. Türsteher can also be used to enforce basic software license management, interface- and device control etc.

Türsteher is just a kernel driver without any additional bulk. Türsteher has a very small binary footprint and is ultra-fast. It does not collect any telemetry data, nor does it require any internet connection to function. Through its simple and solid design YOU have full control. It complies with GDPR. You may easily write your own additional admin tools and scripts.

Türsteher supports 32-bit and 64-bit Editions of Windows starting with Windows 7. Türsteher even runs on current Windows Server, including Windows Server Core.

<h2>Disclaimer</h2>

Türsteher and its components is licensed and provided “as is”. You bear the risk of use. We (I) do not express any warranties, representations or conditions. You may not claim any direct or other damages, including consequential damages, lost profits, special, indirect or incidental damages. Consider yourself warned and informed.

<h2>Target Audience</h2>

This tool has been released for a technical audience. Using it requires technical skills such as understanding basics of windows configuration, forensic analysis, malware analysis, and using command line tools.

<h2>How to Setup Türsteher</h2>

Before you can install and run the driver, you shall setup a configuration file. The configuration of Türsteher is located in C:\Windows\Tursteher.ini. The file shall be in Unicode format (UTF-16 LE). The specified rules are *not* case-sensitive. Türsteher also supports wildcards. You can use these to generalise rules. For example, you can use *.scr to define that all files with extension .scr should be allowed or blocked. Türsteher recognises the star * for any number of characters and the question mark ? for exactly one character. After each change of tuersteher.ini, the driver must be restarted. The first rule fitting the best, is the rule that is taken. You shall always put the most important rule on a higher position in the tuersteher.ini.

Here we have an example of a basic tuersteher.ini file:

<pre>
# Ensure to save this file in UTF-16 LE mode
[#INSTALLMODE]
[#LETHAL]
[LOGGING]
[CMDCHECK]
[#ADMINBYPASS]
[CNAMELOGGING]
[ALLOWLIST]
C:\Windows\*
C:\Program Files\*
C:\Program Files (x86)\*
C:\ProgramData\Microsoft\*
[BLOCKLIST]
C:\Windows\System32\msiexec.exe
C:\Program Files\Internet Explorer\iexplore.exe
C:\Program Files (x86)\Internet Explorer\iexplore.exe
[CMDALLOWLIST]
!*explorer.exe>*wscript.exe*C:\Firmenskripte\*
*>*
[CMDBLOCKLIST]
*explorer.exe>*wscript.exe*
[EOF]

# File shall end with a blank line after [EOF]
</pre>

<h3>Using the hashtag (#)</h3>
The hashtag (#) means switched off or comments a line out. To disable an option use # within the brackets [# ...], e.g. [#LETHAL]. To disable a rule just specify # at the beginning of a line like #C:\Users\Test\*.exe.

<h3>Lethal Mode</h3>
We call Türsteher to be in lethal mode if Türsteher will enforce any of your specified rules. I.e. Türsteher will block excutables. If you are using Türsteher for the very first time you shall start with [#LETHAL] option. This allows you to test the settings without causing problems. Be super cautious if you are using Türsteher for the first time or you risk to brick your system!

Once you have completed and tested the configuration, you can activate Türsteher by setting [LETHAL].

<h3>The Log File</h3>
We recommend that you always activate logging, specify [LOGGING]. Türsteher then writes each event to the log file (C:\Windows\tuersteher.log). For example, if a program tries to start, that was not specified in the allowlist. If you do not like to log, disable it by specifying [#LOGGING].

<h4>Log the Computer Name</h4>
If you'd like to deploy Türsteher on larger scale you may analyse logs centrally. You then need to differentiate between files coming from different machines. One way is to differentiate by the computer’s name. You can activate this feature by setting [CNAMELOGGING], and deactivate it by [#CNAMELOGGING].

<h3>Command Line Checking</h3>
If you’d like to use Türsteher’s Command line checking engine, enable it by setting [CMDCHECK]. If you do not want to use Command line checking, specify [#CMDCHECK].

<h3>Admin-Bypass Mode</h3>
The Admin-bypass feature lets you bypass system and admin processes. This may help to reduce the complexity of your rules. **Beware** there is additional risk with this option, because malicious executables may run as SYSTEM or in the admin group. You can activate this feature by setting [ADMINBYPASS], and deactivate it by [#ADMINBYPASS].


<h3>Configure Allowlist</h3>

<pre>
[ALLOWLIST]
C:\Windows\*
C:\Program Files\*
C:\Program Files (x86)\*
C:\ProgramData\*
</pre>

In the [ALLOWLIST] you shall specify all paths from which executables are allowed to be started. Here you should define at least the file paths that are absolutely necessary for the operation of Windows and the programs you have installed. I.e. in particular all paths (or files) required by the Windows operating system. Usually these are:

<pre>
C:\Windows\*
C:\Program Files\*
C:\ProgramData\Microsoft\*
</pre>

If you are using a 64-bit version of Windows, you will also find the path for installed 32-bit programs:

<pre>
C:\Program Files (x86)\*
</pre>

Make sure that you end each rule with the * symbol. Its a wildcard and allows all files and subdirectories in these folders.

<h4>Add trusted executables to the allowlist</h4>

If you have installed additional  executables in other directories than C:\Program Files\, you need to add them onto the allowlist. For example:

<pre>
D:\PortableApps\VeraCrypt\*
D:\PortableApps\Gimp\*
</pre>

In addition to paths you can also enter individual  executables in the allowlist. To do so, write the complete path with the file name and its extension in one line.

<h3>Configure the Blocklist</h3>

Below the entry [BLOCKLIST] you define all paths from which no program code is allowed to be started. Programs on this list are automatically blocked. Suppose a security hole has been discovered in Microsoft Browser Internet Explorer and there is no update for this vulnerability yet. With just a line in the blocklist you can avoid running untrusted or exploitable applications or libraries. Once the vulnerability has been patched you can simply remove the rules, use the application again.

<pre>
[BLOCKLIST]
C:\Windows\System32\msiexec.exe
C:\Program Files\Internet Explorer\iexplore.exe
C:\Program Files (x86)\Internet Explorer\iexplore.exe
</pre>

**Suggestion:**  Instead of an entire directory it may also be appropriate to disable certain files, such as a vulnerable DLL to a plug-in, for example, if they are at risk due to a security breach. It is often the case that certain libraries or plug-ins are vulnerable to attacks. Cyber criminals use exploits to trigger the security breach in such libraries/plug-ins to infect your computer. If you block the vulnerable library or plug-in using Türsteher’s blocklist, they can no longer be exploited. After the libraries or plug-ins have been updated, you can remove the rule from the blocklist and use them again.

Please note: Disabling drivers, libraries or plug-ins sometimes result in stopping the application or system from working properly. Hence, before disabling any executable you shall always test the behaviours and be careful with what you disable. We heavily encourage you to do some testing on demo or test machines, before deploying any updated Türsteher blocklist rules to a production line computer system.

<h3>Command Line Checking</h3>

In addition Türsteher also support Command Line Checking. This option is beyond traditional Application Allow-/Blocklisting and gives you even more control. We suggest that you turn Türsteher into [#LETHAL] mode and have a look into the log while [CMDCHECK] is enabled. The configuration heavily depends on your requirements, so it is hard to give advice here. Just try it out. Türsteher provides a Allow- and Blocklist for Command Line Checking. You shall specify them at [CMDALLOWLIST] and [CMDBLOCKLIST].

<h3>Priority Rules</h3>

Priority rules are rules, that can overwrite any other rules, whether they are on the allow- or blocklist. Although Türsteher supports a very powerful rules mechanism, priority rules provide more flexibility. Priority rules can help to reduce the number of specific rules for example by just blocklisting a whole directory and allowlisting specific executables you would like to allow. For example, we recommend blocklisting the path C:\Windows\Temp\*. All programs that are in this directory can no longer be started. However, it can happen that certain update programs and installers want to execute their processes in this folder. A priority rule can solve this problem. To do this, we give the desired rule a higher priority in the [ALLOWLIST] with an exclamation mark. The rule in the allowlist now overrides the rule in the blocklist. Let's assume that the desired update is AVUpdater.exe. Then the rules are as follows:

<pre>
[ALLOWLIST]
!C:\Windows\Temp\AVUpdater.exe
[BLOCKLIST]
C:\Windows\Temp\*
</pre>

Priority rules are supported in the allow- and blocklist, also for the command line check option. Please note: Rules with a higher priority must be in first order.

<h3>Transitive Rules (Parentchecking)</h3>

Türsteher also supports conditional rules for parent processes in the [ALLOWLIST] and [BLOCKLIST]. There are programs that start subprograms as required after starting the main program. We call the main program the parent process, the subprograms child processes. The fact that parent processes start subprograms, i.e. child processes, is necessary and useful for programs such as the Explorer. But hackers use this technique to execute their evil executables through media players, browsers or office applications. For example, a Word document contains a macro which forces Word to download and execute a cryptolocker. With parentchecking Türsteher can block such attacks.

During parentchecking, Türsteher checks which parent processes wants to start the executable before starting the child process. If the corresponding parent is on the allowlist, the child is allowed to start, otherwise it will be blocked. For example, you can define that your Mailclient or Wordprocessor cannot execute processes, shell codes, runtime libraries or drivers (.dll, .sys, .ocx, .drv, .cpl). This can help to mitigate against a whole bunch of attack vectors if you specify the rules tight.

The rules for parent checking have the following general format: 
Parent>Child
Please note: A path- or filename is separated by the > symbol. No spaces are allowed in between.

<h3>Silent Rules</h3>
Silent Rules allow you to block events which you do not want showing up in the logs. So, with Silent Rules you are able to calm down annoying alerts you cannot get rid of, because e.g. the operating system's core automatically triggers them without any chance to block them.

For example: If you would like to blocklist a Windows’ core library or driver that cannot be removed via the system’s configuration, and thus causing “harmless” alerts each and every time the operating systems tries to launch it. There is no way to avoid such attempts, but with Silent Rules you are able to calm them down. Just specify the $ character before a blocklist rule and it will not show up in the logs.

A simple silent rule is shown here:

<pre>
[BLOCKLIST]
$*notepad.exe
</pre>

This example rule defines that notepad.exe should be blocked and that no log entry should be written to the log file. If Notepad is getting started, it will be blocked by Türsteher without any event logged.

Please note: Silent rules can only be specified in the blocklist areas [BLOCKLIST] and [CMDBLOCKLIST].

<h3>End of configuration</h3>

The configuration file shall always end with the following line, *followed by a blank line*:

<pre>
[EOF]

</pre>

Please note that Türsteher does not accept the configuration file and does not load the driver if it is not completed with [EOF].

<h2>Install the Türsteher Driver (tuersteher.sys)</h2>

Make use of the driver_install.cmd script. If you want to install the driver manually first read the EULA and accept it. Then check the driver_install.cmd script for more details. Before you can start Türsteher you shall specify a proper tuersteher.ini in C:\Windows\. Without that .ini the driver will not load.

<h3>Anti-Virus Warnings</h3>

Maybe your browser or your AV warns you when you download Türsteher or its components. These are false-positive warnings. We have been struggling to remove Türsteher from the blocklist of well known AV products. In many cases without success. Türsteher is no malware. Türsteher is no rootkit. Türsteher is not dangerous.

<h2>Support this Project</h2>

If you like Türsteher consider to donate BTC: *bc1qy2xa6crhtlwlyumjfyvsld48f45635y2tnj32p*

Thanks.

<h2>About Open Source</h2>

I do not plan to share the source code of this tool for free. But I will soon publish a demo skeleton driver so you can develop your own one.

<h2>Device Control</h2>

You can use Türsteher as a simple device control endpoint protection. All you need to do is to block the drivers of external devices you would like to block. As a very simple example check out this blocklist:

<pre>
### Simple Device Control ###
*WpdUpFltr.sys
*USBSTOR.SYS
*AppleLowerFilter.sys
*usbprint.sys
*usbport.sys
*sfloppy.sys
*serial.sys
*sermouse.sys
*sdstor.sys
*sdport.sys
*sdbus.sys
*bth*.sys
*rfcomm.sys
*Bluetooth*.sys
*BtaMPM.sys
*cdrom.sys
*hidbth.sys
*usbaudio.sys
*usbaudio2.sys
*usbcamd2.sys
*ax88179_178a.sys
*rtwlanu.sys
*WdiWiFi.sys
*vwifibus.sys
*vwififlt.sys
*vwifimp.sys
*scfilter.sys
### Simple Device Control ###
</pre>

If you would like to go further you can generate a list of allowed drivers in "training mode", then only allow drivers your endpoints really need to function. Then block all other drivers (*.sys). To keep it simple you could start with blocking

<pre>
*WpdUpFltr.sys
*USBSTOR.SYS
*AppleLowerFilter.sys
*sfloppy.sys
*serial.sys
*sermouse.sys
*sdstor.sys
*sdport.sys
*sdbus.sys
*cdrom.sys
</pre>

<h2>Contact</h2>

E-mail me via HazelFazel <nospam>(at)</nospam> bitnuts.de

I only reply to E-mails I am interested in and if I have time to answer. I am busy.
