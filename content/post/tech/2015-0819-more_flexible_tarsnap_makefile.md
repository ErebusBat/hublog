+++
Tags = ["tarsnap", "makefile"]
date = "2015-08-19T13:26:07-06:00"
title = "More flexible tarsnap backups with a Makefile"

+++
Better tarsnap backup management by using a Makefile.
<!--more-->
Last time I [wrote about tarsnap](/2015/08/two-days-with-tarsnap) I had just started using [Tarsnapper](https://github.com/miracle2k/tarsnapper), which is an awesome wrapper around the even more awesome tarsnap utility.

I found my scheduling and task management still slightly wanting, as I mentioned at the end of my last post.

I decided to simplify (really it **is** simpler, I promise!) by only having one crontab entry per timeframe (daily/hourly).  

I don't really foresee needing any less frequent backups than daily.  Tarsnap will store how ever long back I tell it to (via tarsnapper), the main reason is to not waste disk/time/bandwidth on things that are not as volatile and just don't need to be backed up on a hourly schedule.

I can easily add or remove targets as needed, or change behavior by simply editing the `Makefile`.  This means I am only focusing on this:

~~~ makefile
...
# Period based targets
daily: aab work notify
hourly: aab-hourly work-hourly notify

# Actual Targets
pers: personal
personal: aab-hourly

aab: aab-hourly aab-daily
aab-hourly:
	@$(call snaprun,aab-hour.conf,$(TARGET))
aab-daily:
	@$(call snaprun,aab-day.conf,$(TARGET))
...
~~~

All the calling is abstracted out to the `snaprun` user defined function in the makefile.

# Scheduling
My updated crontab looks something like:

~~~ cron
3 0-15,17-23 * * * /bin/bash -l -c 'cd /Users/ErebusBat/.tarsnap && make hourly >> /Users/ErebusBat/.tarsnap/tarsnapper.log 2>&1'
3 16         * * * /bin/bash -l -c 'cd /Users/ErebusBat/.tarsnap && make daily  >> /Users/ErebusBat/.tarsnap/tarsnapper.log 2>&1'
~~~

Other than the time differences, the only change is the makefile target.

I needed two different lines because I made the choice to have a daily backup imply an hourly backup.  This was so that I didn't have two processes running at the same time.  Tarsnap would fail in that event and one of the backups would ultimately fail.

I chose 4pm as my daily time because it provides the time when most of my daily work output would have been done AND the most likely time my laptop would still be on.  Sometimes if I take it home and then do not get on it then it would not be powered up for a late night backup.

Another benefit of this design is my work back will run as soon as my personal backup is finished.  Before this change then, best case, my work backup would wait until the given time in cron to activate.  Worst case if my personal was not finished then the work backup would fail (due to an ongoing tarsnap transaction).

# Manual
Sometimes you make a change and you want it backed up right away.  I still have that ability:

~~~ bash
TARGET=blog make aab work
~~~

That will process only the tarsnapper `src` target, regardless if it is personal or work, it might look something like:

~~~
################################################################################
## Started aab-hourly - Wed Aug 19 13:52:09 MDT 2015
##     /Users/aburns/.tarsnap/conf.d/aab-hour.conf
################################################################################
Error: not defined in the config file: blog
############### END - aab-hourly - Wed Aug 19 13:52:09 MDT 2015



################################################################################
## Started aab-daily - Wed Aug 19 13:52:09 MDT 2015
##     /Users/aburns/.tarsnap/conf.d/aab-day.conf
################################################################################
Creating backup blog: /horcrux/blog-20150819-195209
3 backups are matching
1 of those can be deleted
Deleting /horcrux/blog-20150819-185254
############### END - aab-daily - Wed Aug 19 13:52:47 MDT 2015
~~~

I got an error (that is why the `|| true` is on the tarsnapper line in the makefile) because blog is only in the daily target.  But that is OK in this event.


## Full Makefile
I am quite happy how this came out. I believe it is a perfect mixture of simplicity/power/flexability.

~~~ Makefile
####################################################################
## Defines
####################################################################
HOME = /Users/ErebusBat
CONF_ROOT = $(HOME)/.tarsnap/conf.d
NOTIFY = /Users/ErebusBat/bin/notify
TARSNAPPER = /usr/local/bin/tarsnapper

################################################################################
## Targets
################################################################################
default: help
help:
	$(info $(HELPTEXT))
	@echo ""

# Period based targets
daily: aab work notify
hourly: aab-hourly work-hourly notify

# Actual Targets
pers: personal
personal: aab-hourly

aab: aab-hourly aab-daily
aab-hourly:
	@$(call snaprun,aab-hour.conf,$(TARGET))
aab-daily:
	@$(call snaprun,aab-day.conf,$(TARGET))


work: work-hourly work-daily
work-hourly:
	@$(call snaprun,work-hour.conf,$(TARGET))
work-daily:
	@$(call snaprun,work-day.conf,$(TARGET))

# Helpers
notify:
	$(NOTIFY) 'Tarsnap Backups Completed'


####################################################################
## Functions
####################################################################

# snaprun [tarsnapper conf file] (tarsnapper targets)
define snaprun
	echo "\n\n"
	echo "################################################################################"
	echo "## Started $@ - $$(date)"
	echo "##     $(CONF_ROOT)/$(1)"
	echo "################################################################################"
	$(TARSNAPPER) -c $(CONF_ROOT)/$(1) make $(2) || true
	echo "############### END - $@ - $$(date)"
endef

define HELPTEXT
####################################################################
## Tarsnap / Tarsnapper Backup Manager
####################################################################

This Makefile manages tarsnap backups using tarsnapper job definitions.
The following targets are available:

TARGETS
        work = All work targets
 work-hourly = Only targets that should be backed up hourly
  work-daily = Only targets that should be backed up daily, impiles hourly

        aab = All aab targets
 aab-hourly = Only targets that should be backed up hourly
  aab-daily = Only targets that should be backed up daily, impiles hourly

      daily = All daily targets
     hourly = All hourly targets

CRONTAB
  You can call this makefile from crontab:

    3 0-15,17-23 * * * /bin/bash -l -c 'cd /Users/ErebusBat/.tarsnap && make hourly >> /Users/ErebusBat/.tarsnap/tarsnapper.log 2>&1'
    3 16 * * * /bin/bash -l -c 'cd /Users/ErebusBat/.tarsnap && make daily >> /Users/ErebusBat/.tarsnap/tarsnapper.log 2>&1'

	That will create a backup at three past the hour, with hourly backups being made every hour, except 4pm.  4:03 pm will create a daily backup (which implies an hourly backup)

	4pm was chosen as the most likley time the laptop would still be on.
endef
~~~


![yo dawg](http://leanmarketing.ca/wp-content/uploads/2013/01/YO-DAWG-I-HEARD-YOU-LIKE-PROCESSES1.jpg)
