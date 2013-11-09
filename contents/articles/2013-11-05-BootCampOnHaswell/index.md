---
title: WIndows 8.1 Bootcamp on new Haswell MBP
author: Jake
date: 2013-11-05
template: article.jade
---

THe long wait is over and I recieved my shiny new retina MBP with 1TB SSD and the new Haswll chipset.  It feels screaming fast and so far I love it.  And I want to be able to use that speed to play a video game occasionally, which means installing windows in bootcamp so you get all the best performance.  My personal preference is to set up windows in bootcamp first, then have fusion or parallels create a VM that uses the bootcamp partition as it's disk, so I can use the VM for day-to-day tasks, then reboot to native if I really need the power.

Armed with a USB key and a windows 8.1 ISO from MSDN, I proceeded to fire up the bootcamp assistant and start the long process of partitioning and installing windows.  Actually, both partitioning and installing are surprisingly fast with the SSD, but downloading the drivers from apple can take a while.  But then at the end of the windows installation, just before reboot, it throws an error "Windows cannot update the boot partition" and I can't get any further.

Some googling turned up that I was not the only one with the issue.  I found a [https://discussions.apple.com/thread/5474320?start=0&tstart=0 lengthy thread] on apple's forums full of people with the same issue exploring various workarounds.  I tried many of them, but finally found success with this:

I let bootcamp assistant partition my drive and create a USB boot disk.  It rebooted to go into the windows installer, but I help down the option key and boot into OSX again instead.  Then I had to use Disk Utility to format the bootcamp  partition as ExFAT.

Manually rebooted with the option key again and chose the 'Windows' (not EFI) boot from the usb drive.  Then in I let had the windows installer reformat the partition again as NTFS.  After that it proceeded to install properly and all went well.

Whew!  I'm still unsure why these incantations brought about success, but I thank the perseverant posters on the discussion board (especially maskedferret) for helping me get all set.
