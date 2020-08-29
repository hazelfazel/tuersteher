<h1>Türsteher</h1>

<h2>About</h2>

Türsteher is a free powerful Windows kernel driver for comprehensive executable white- and blacklisting for any kind of executable (exe, com, scr, sys, dll, ocx). Türsteher works according to the exclusion principle using a whitelist: All explicitly allowed executables run as desired. Türsteher also supports a blacklist where you can specify executables to block. In addition Türsteher supports parent - child rules, so you can specify what executable an application is allowed to start. The driver also support command line rules. This is a very powerful option for malware analysis. We used Türsteher for many years to quickly track down the path of infection without need for a sophisticated analysis environment. Türsteher also helped us to examine software issues on big scaled installations. Türsteher can also be used to enforce software license management, interface control etc.

Türsteher is just a kernel driver without any additional bulk. Türsteher has a damn small binary footprint and is ultra-fast. It does not collect any telemetry data, nor does it require any internet connection to function. Through its simple and solid architecture you have control. It complies with GDPR. You may easily write your own additional tools.

<h2>Disclaimer</h2>

Türsteher and its components is licensed and provided “as is”. You bear the risk of use. We do not express any warranties, representations or conditions. You may not claim any direct or other damages, including consequential damages, lost profits, special, indirect or incidental damages. Consider yourself warned and informed.

<h2>Target Audience</h2>

IT- and Security Professionals. You should know about the Windows OS, its architecture, current malware attack strategies and how to defeat them.

<h2>How to Setup Türsteher</h2>

Before you can install and run the driver, you shall setup a configuration file for Türsteher. The configuration of Türsteher is located in C:\Windows\Tursteher.ini. The file shall be in Unicode format. The specified rules are *not* case-sensitive. In addition, Türsteher also support wildcards. You can use these to generalise rules. For example, you can use *.scr to define that all files with extension .scr should be blocked. Türsteher recognises the star * for any number of characters and the question mark ? for exactly one character. After each change of tuersteher.ini, the driver must be restarted. The first rule fitting the best, is the rule that is taken. You shall always put the most important rule on a higher position in the tuersteher.ini.

Here we have an example of a basic tuersteher.ini file:

<pre>
[#INSTALLMODE]
[#LETHAL]
[LOGGING]
[CMDCHECK]
[#ADMINBYPASS]
[CNAMELOGGING]
[WHITELIST]
C:\Windows\*
C:\Program Files\*
C:\Program Files (x86)\*
C:\ProgramData\Microsoft\*
[BLACKLIST]
C:\Windows\System32\msiexec.exe
C:\Program Files\Internet Explorer\iexplore.exe
C:\Program Files (x86)\Internet Explorer\iexplore.exe
[CMDWHITE-LIST]
!*explorer.exe>*wscript.exe*C:\Firmenskripte\*
*>*
[CMDBLACKLIST]
*explorer.exe>*wscript.exe*
[EOF]
</pre>

<h3>Using the hashtag (#)</h3>
The hashtag (#) means switched off or comment a line out. To disable an option use use # within the brackets [# ...], e.g. [#LETHAL]. To disable a rule just specify # at the beginning of a line like #C:\Users\Test\*.exe.

<h3>Lethal Mode</h3>
We call Türsteher to be in lethal mode if Türsteher will enforce any of your specified rules. I.e. Türsteher will block excutables. If you are using Türsteher for the first time you shall start with [#LETHAL] option. This allows you to test the settings without causing problems with incorrect configurations. Be super cautious if you are using Türsteher for the first time or you risk to brick your system!
Once you have completed and tested the configuration, you can activate Türsteher by setting [LETHAL]. Now unknown and dangerous programs are blocked.

<h3>The Log File</h3>
We recommend that you always activate logging, [LOGGING] = on. Türsteher then writes each event to the log file (C:\Windows\Türsteher.log). For example, if a program tries to start, that was not specified in the whitelist. If you do not like to log, disable it by specifying [#LOGGING].
Log the Computer Name
If you'd like to deploy Türsteher in a larger scale you may analyse the logs centrally. Then you need to differentiate between files coming from different machines. One way is to differentiate by the computer’s name. You can activate this feature by setting [CNAMELOGGING], and deactivate it by [#CNAMELOGGING].

<h3>Command Line Checking</h3>
If you’d like to use Türsteher’s Command line checking engine, enable it by setting [CMDCHECK]. If you do not want to use Command line checking, specify [#CMDCHECK].

<h3>Admin-Bypass Mode</h3>
The Admin-bypass feature allows you to bypass system and admin processes. This helps to reduce the complexity of your rules, and on how you install patches or updates which often require SYSTEM/admin privileges. On the other hand, we must point out that there is an additional risk with this option, because malicious executables running as SYSTEM or in the admin group could also bypass. So, you need to balance between security and comfort, but you now have a choice. You can activate this feature by setting [ADMINBYPASS], and deactivate it by [#ADMINBYPASS].


<h3>Configure Whitelist</h3>

<pre>
[WHITELIST]
C:\Windows\*
C:\Program Files\*
C:\Program Files (x86)\*
C:\ProgramData\*
</pre>

Below the entry [WHITELIST] you shall specify all paths from which executables are allowed to be started. Here you should define at least the file paths that are absolutely necessary for the operation of Windows and the programs you have installed, i.e. in particular all paths (or files) required by the Windows operating system. Usually these are:

<pre>
C:\Windows\*
C:\Program Files\*
C:\ProgramData\Microsoft\*
</pre>

If you are using a 64-bit version of Windows, you will also find the path for installed 32-bit programs:
C:\Program Files (x86)\*
Make sure that you end each rule with the * symbol. The star symbol serves as wildcard and allows all files and subdirectories in these folders.

<h4>Add trusted executables to the whitelist</h4>

If you have installed additional  executables in other directories than C:\Program Files\, you need to add them onto the whitelist. For example:

<pre>
D:\PortableApps\VeraCrypt\*
D:\PortableApps\Gimp\*
</pre>

In addition to path specifications, you can also enter individual  executables in the whitelist. To do so, write the complete path with the file name and its extension in one line.

<h3>Priority Rules</h3>

Priority rules are rules, that can overwrite any other rules, whether they are on the white- or blacklist. Although Türsteher supports a very powerful rules mechanism, priority rules provide more flexibility. Priority rules can help to reduce the number of specific rules for example by just blacklisting a whole directory and whitelisting specific executables you would like to allow. For example, we recommend blacklisting the path C:\Windows\Temp\*. All programs that are in this directory can no longer be started. However, it can happen that certain update programs and installers want to execute their processes in this folder. A priority rule can solve this problem. To do this, we give the desired rule a higher priority in the [WHITELIST] with an exclamation mark. The rule in the whitelist now overrides the rule in the blacklist. Let's assume that the desired update is AVUpdater.exe. Then the rules are as follows:

<pre>
[WHITELIST]
!C:\Windows\Temp\AVUpdater.exe
[BLACKLIST]
C:\Windows\Temp\*
</pre>

Priority rules are supported in the white- and blacklist, also for the command line check option. Please note: Rules with a higher priority must be in first order.

<h3>Configure the Blacklist</h3>

Below the entry [BLACKLIST] you define all paths from which no program code is allowed to be started. Programs on this list are automatically blocked. Suppose a security hole has been discovered in Microsoft Browser Internet Explorer and there is no update for this vulnerability yet. With just some line in the blacklist you can avoid running untrusted or exploitable applications or libraries. Once the vulnerability has been patched you can simply remove the rules, use the application again.

<pre>
[BLACKLIST]
C:\Windows\System32\msiexec.exe
C:\Program Files\Internet Explorer\iexplore.exe
C:\Program Files (x86)\Internet Explorer\iexplore.exe
</pre>

Suggestion:  Instead of an entire directory, it may also be appropriate to disable certain files, such as a vulnerable DLL to a plug-in, for example, if they are at risk due to a security breach. It is often the case that certain libraries or plug-ins are vulnerable to attacks. Cyber criminals use exploits to trigger the security breach in such libraries/plug-ins to infect your computer. If you block the vulnerable library or plug-in using Türsteher’s blacklist, they can no longer be exploited. After the libraries or plug-ins have been updated, you can remove the rule from the blacklist and use them again.

Please note: Disabling drivers, libraries or plug-ins sometimes result in stopping the application or system from working properly. Hence, before disabling any executable you shall always test the behaviours and be careful with what you disable. We heavily encourage you to do some testing on demo or test machines, before deploying any updated Türsteher blacklist rules to a production line computer system.

<h3>Silent Rules</h3>
Silent Rules allow you to block events which you do not want showing up in the logs. So, with Silent Rules you are able to calm down annoying alerts you cannot get rid of, because e.g. the operating system's core automatically triggers them without any chance to block them.

For example: If you would like to blacklist a Windows’ core library or driver that cannot be removed via the system’s configuration, and thus causing “harmless” alerts each and every time the operating systems tries to launch it. There is no way to avoid such attempts, but with Silent Rules you are able to calm them down. Just specify the $ character before a blacklist rule and it will not show up in the logs.

A simple silent rule is shown here:

<pre>
[BLACKLIST]
$*notepad.exe
</pre>

This example rule defines that notepad.exe should be blocked and that no log entry should be written to the log file. If Notepad is getting started, it will be blocked by Türsteher without any event logged.

Please note: Silent rules can only be specified in the blacklist areas [BLACKLIST] and [CMDBLACKLIST].

<h3>Transitive Rules (Parentchecking)</h3>

Türsteher also supports conditional rules for parent processes in the [WHITELIST] and [BLACKLIST]. There are programs that start subprograms as required after starting the main program. We call the main program the parent process, the subprograms child processes. The fact that parent processes start subprograms, i.e. child processes, is necessary and useful for programs such as the Explorer. But hackers use this technique to execute their evil executables through media players, browsers or office applications. For example, a Word document contains a macro which forces Word to download and execute a cryptolocker. With parentchecking Türsteher can block such attacks.

During parentchecking, Türsteher checks which parent processes wants to start the executable before starting the child process. If the corresponding parent is on the whitelist, the child is allowed to start, otherwise it will be blocked. For example, you can define that your Mailclient or Wordprocessor cannot execute processes, shell codes, runtime libraries or drivers (.dll, .sys, .ocx, .drv, .cpl). This can help to mitigate against a whole bunch of attack vectors if you specify the rules tight.

The rules for parent checking have the following general format: 
Parent>Child
Please note: A path- or filename is separated by the > symbol. No spaces are allowed in between.

<h3>End of configuration</h3>

The configuration file shall always end with the following line:

<pre>
[EOF]
</pre>

Please note that Türsteher does not accept the configuration file and does not load the driver if it is not completed with [EOF].

<h2>Install the Türsteher Driver (türsteher.sys)</h2>

Make use of the driver_install.cmd script. If you want to install the driver manually first read the EULA and accept it. Then check the driver_install.cmd script for more details.

<h3>Anti-Virus Warnings</h3>

Maybe the browser or your below average AV warns you when you download Türsteher. This is a false-positive. We have been struggling to remove Türsteher from the blacklist of well known below average AV products. In many cases without success. Türsteher is no malware. Türsteher is no rootkit. Türsteher is not dangerous. It is just that below average AV companies that seem to dislike us. More and more serious IT magazines and IT Pros already postulate: If you use MS Defender you are very well protected. We say: If you supplement MS Defender with Application Whitelisting (like AppLocker or Türsteher), you are well prepared without any annual subscription fees. So what could be the cause for blocking Türsteher ....... hmmmmm ....... we don’t know ....... very difficult to imagine ....... 😉

<h2>Additional Services (may require a formal agreement, NDA)</h2>
<ul>
  <li>Consulting and Pro Service Support</li>
  <li>Driver (binary) customisation</li>
  <li>White-Label Release / Your Company Name Release</li>
  <li>Driver source code (under NDA)</li>
</ul>

<h2>About Open Source</h2>

I do not plan to share the source code of this tool for free.

<h2>FAQ</h2>

Lorem ipsum...

<h2>Contact</h2>

E-mail me via HazelFazel <nospam>(at)</nospam> bitnuts.de

<ul>
  <li>If you find bugs, have constructive suggestions contact me</li>
  <li>If you would like to request for additional pro service support or consulting, please contact me. I will only answer requests coming from real existing professionals or organisations. Do not waste my time with phony or cheeky requests.</li>
  <li>I only reply to E-mails I am interested in.</li>
</ul>

