FROM fedora:24
MAINTAINER "Pavel Studenik" <pstudeni@redhat.com>

RUN rpm -Uvh http://yum.spacewalkproject.org/nightly-client/Fedora/24/x86_64/spacewalk-client-repo-2.5-3.fc24.noarch.rpm
RUN sed s/enabled=0/enabled=1/g /etc/yum.repos.d/spacewalk-client-nightly.repo -i && \
    sed s/enabled=1/enabled=0/g /etc/yum.repos.d/spacewalk-client.repo -i
RUN dnf install rhn-client-tools rhn-check rhn-setup rhnsd m2crypto wget osad -y

ADD bin/register.sh /root/register.sh
ADD bin/osad.sh /root/osad.sh

RUN chmod a+x /root/{register.sh,osad.sh}

CMD /root/osad.sh
