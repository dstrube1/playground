from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
import commands
import sys

# starting script
print "start"

# connection to the current device, and return a MonkeyDevice object
device = MonkeyRunner.waitForConnection()

apk_path = device.shell('pm path com.dstrube.bugsensetest')
if apk_path.startswith('package:'):
    print "BugSenseTest already installed."
else:
    print "BugSenseTest not installed, installing APKs..."
    device.installPackage('bugsensetest.apk')

#print "launching BugSenseTest..."
#device.startActivity(component='com.dstrube.bugsensetest/com.dstrube.bugsensetest.MainActivity')

#screenshot
#MonkeyRunner.sleep(1)
#result = device.takeSnapshot()
#result.writeToFile('./screenshots/splash.png','png')
#print "screen 1 taken"

#sending an event which simulate a click on the menu button
#device.press('KEYCODE_MENU', MonkeyDevice.DOWN_AND_UP)

print "end of script"