# Sample Dockerfile for the AppDynamics Standalone Machine Agent
# This is provided for illustration purposes only, for full details 
# please consult the product documentation: https://docs.appdynamics.com/

FROM centos:latest

# Install required packages
RUN yum update -y
RUN yum install -y unzip
RUN yum -y install java-1.8.0-openjdk

# Install AppDynamics Machine Agent
ENV MACHINE_AGENT_HOME /opt/appdynamics/machine-agent/
ADD machine-agent.zip /tmp/ 
RUN mkdir -p ${MACHINE_AGENT_HOME} && \
    unzip -oq /tmp/machine-agent.zip -d ${MACHINE_AGENT_HOME} && \
    rm /tmp/machine-agent.zip

# Include start script to configure and start MA at runtime
ADD start-appdynamics ${MACHINE_AGENT_HOME}
RUN chmod 744 ${MACHINE_AGENT_HOME}/start-appdynamics

# Configure and Run AppDynamics Machine Agent
CMD "${MACHINE_AGENT_HOME}/start-appdynamics"
