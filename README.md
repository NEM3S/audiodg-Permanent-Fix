# audiodgFix
Fixing permanently VoiceMeeter voice issues by creating scheduler task.
## Presentation
This is a batch file with PowerShell code in it.<br>
It creates a new scheduler task, named "audiodgFIX", which triggers a PowerShell script that sets the priority of audiodg to high and assigns affinity to one core.
## Setup
Start the ***.bat*** file and accept the **UAC** box.
## Uninstall
Open the *Task Scheduler* and delete the "audiodgFIX" task.
<br>
<br>
Enjoy!<br>
<sup>If you get some troubles, tell me in `Issues` section.</sup>
