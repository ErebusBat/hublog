+++
Tags = ["ios", "mdm"]
date = "2015-06-29T10:10:26-06:00"
title = "App won't Install with Apple Configurator"
+++

Recently at work we had the need to provision roughly ten iPads in a secure way for a single app usage scenario.

I was making good progress using [Apple Configurator](https://itunes.apple.com/us/app/apple-configurator/id434433123?mt=12) (AC) to lock down the iPad.  Then all of the sudden my app wouldn't install on the iPad, despite being very clearly checked on the _App_ tab of the AC interface.

This was especially troubling because it had worked just the day before.

After some looking around I found the culprit.  Due to my over zealousness I i had changed a very innocuous feature that prevented _any_ apps from being installed, even ones I specified in AC.

The offending setting is configured in the _Restrictions_ payload, under the _Media Content_ section there is a drown down for App ratings.  A quick and naive reading of that section might think that is just for downloading apps; however it will also block AC from installing them as well.

![AC No Apps](/img/2015/06-AC-no-apps.png)

Changing the setting back to _Allow All Apps_ and a quick refresh in AC later and my app appeared as expected.

I am OK leaving this setting as it because there is another setting under the _Apps_ tab that disables the App Store altogether.  When enabled the App Store icon doesn't even appear on the device.

![AC No App Store](/img/2015/06-AC-no-app-store.png)
