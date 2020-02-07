# Mapping the dir of WSL to Windows as local disk
# DELETE: subst L: /D

# 1.a path should not be trailed by a backslash;
# 2.the root path should be ended by a backslash. For example, these are correct

# Mapping root of Ubuntu to l:
# subst l: C:\Users\secf4\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs

# Mapping root of Debian to m:
subst l: C:\Users\secf4\AppData\Local\Packages\TheDebianProject.DebianGNULinux_76v4gfsz19hv4\LocalState\rootfs

# Mapping root of Kali Linux to n:
# subst l: C:\Users\secf4\AppData\Local\Packages\KaliLinux.54290C8133FEE_ey8k8hqnwqnmg\LocalState\rootfs

# Mapping root of OpenSUSE to o:
# subst l: C:\Users\secf4\AppData\Local\Packages\46932SUSE.openSUSELeap42.2_022rs5jcyhyac\LocalState\rootfs