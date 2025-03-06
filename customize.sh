SKIPUNZIP=1

status=""
architecture=""
system_gid="1000"
system_uid="1000"
clash_data_dir="/data/clash"
modules_dir="/data/adb/modules"
ca_path="/system/etc/security/cacerts"
mod_config="${clash_data_dir}/clash.config"
geoip_file_path="${clash_data_dir}/GeoIP.dat"

case "${ARCH}" in
    arm)
        arch_folder="armv7"
        ;;
    arm64)
        arch_folder="arm64"
        ;;
    x86)
        arch_folder="386"
        ;;
    x64)
        arch_folder="amd64"
        ;;
    *)
        ui_print "- 错误：不支持的架构 ${ARCH}"
        exit 1
        ;;
esac

mkdir -p ${MODPATH}/system/bin
mkdir -p ${clash_data_dir}
mkdir -p ${MODPATH}${ca_path}

unzip -o "${ZIPFILE}" -x 'META-INF/*' -d $MODPATH >&2

mv -f ${clash_data_dir} ${clash_data_dir}.old
mkdir ${clash_data_dir}
mv -f ${MODPATH}/binary/${arch_folder}/* ${MODPATH}/system/bin/
mv ${MODPATH}/cacert.pem ${MODPATH}${ca_path}
mv -f ${MODPATH}/clash/* ${clash_data_dir}/
rm -rf ${MODPATH}/clash
rm -rf ${MODPATH}/binary

if [ ! -f "${clash_data_dir}/packages.list" ] ; then
    touch ${clash_data_dir}/packages.list
fi

sleep 1

ui_print "- 开始设置环境权限."

if [[ "$KSU" == "true" ]]; then
    echo "/data/adb/ksu/bin/busybox" > "${MODPATH}/busybox"
elif [[ "$APATCH" == "true" ]]; then
    echo "/data/adb/ap/bin/busybox" > "${MODPATH}/busybox"
else
    echo "/data/adb/magisk/busybox" > "${MODPATH}/busybox"
fi

set_perm_recursive ${MODPATH} 0 0 0755 0644
set_perm  ${MODPATH}/system/bin/setcap  0  0  0755
set_perm  ${MODPATH}/system/bin/getcap  0  0  0755
set_perm  ${MODPATH}/system/bin/getpcaps  0  0  0755
set_perm  ${MODPATH}${ca_path}/cacert.pem 0 0 0644
set_perm  ${MODPATH}/system/bin/curl 0 0 0755
set_perm_recursive ${clash_data_dir} ${system_uid} ${system_gid} 0755 0644
set_perm_recursive ${clash_data_dir}/scripts ${system_uid} ${system_gid} 0755 0755
set_perm  ${MODPATH}/system/bin/clash  ${system_uid}  ${system_gid}  6755
set_perm  ${clash_data_dir}/clash.config ${system_uid} ${system_gid} 0755
set_perm  ${clash_data_dir}/packages.list ${system_uid} ${system_gid} 0644
