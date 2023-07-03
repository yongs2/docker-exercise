#!/bin/bash
# Inspired from https://github.com/hhcordero/docker-jmeter-client
# Basically runs jmeter, assuming the PATH is set to point to JMeter bin-dir (see Dockerfile)
#
# This script expects the standdard JMeter command parameters.
#

# Install jmeter dependencies lib available on /dependencies volume
if [ -d $JMETER_CUSTOM_DEPENDENCIES ]
then
    echo ">> $JMETER_CUSTOM_DEPENDENCIES"
    for dependency in ${JMETER_CUSTOM_DEPENDENCIES}/*.jar; do
        echo "cp $dependency ${JMETER_HOME}/lib"
        cp $dependency ${JMETER_HOME}/lib
    done;
    echo "<< $JMETER_CUSTOM_DEPENDENCIES"
fi

# Install jmeter plugins available on /plugins volume
if [ -d $JMETER_CUSTOM_PLUGINS_FOLDER ]
then
    echo ">> $JMETER_CUSTOM_PLUGINS_FOLDER"
    for plugin in ${JMETER_CUSTOM_PLUGINS_FOLDER}/*.jar; do
        echo "cp $plugin ${JMETER_HOME}/lib/ext"
        cp $plugin ${JMETER_HOME}/lib/ext
    done;
    echo "<< $JMETER_CUSTOM_PLUGINS_FOLDER"
fi

# Install jmeter properties available on /properties volume
if [ -d $JMETER_CUSTOM_PROPERTIES ]
then
    echo ">> $JMETER_CUSTOM_PROPERTIES"
    for property in ${JMETER_CUSTOM_PROPERTIES}/*.properties; do
        echo "cp $property ${JMETER_HOME}/bin"
        cp $property ${JMETER_HOME}/bin
    done;
    echo "<< $JMETER_CUSTOM_PROPERTIES"
fi

if [ "X${JVM_ARGS}" = "X" ]
then
    # Execute JMeter command
    set -e
    freeMem=`awk '/MemAvailable/ { print int($2/1024) }' /proc/meminfo`

    [[ -z ${JVM_XMN} ]] && JVM_XMN=$(($freeMem/10*2))
    [[ -z ${JVM_XMS} ]] && JVM_XMS=$(($freeMem/10*8))
    [[ -z ${JVM_XMX} ]] && JVM_XMX=$(($freeMem/10*8))

    export JVM_ARGS="-Xmn${JVM_XMN}m -Xms${JVM_XMS}m -Xmx${JVM_XMX}m"
fi
echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

# Keep entrypoint simple: we must pass the standard JMeter arguments
EXTRA_ARGS=-Dlog4j2.formatMsgNoLookups=true
echo "jmeter ALL ARGS=${EXTRA_ARGS} $@"
jmeter ${EXTRA_ARGS} $@

echo "END Running Jmeter on `date`"
