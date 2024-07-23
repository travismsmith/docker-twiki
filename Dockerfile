FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y dist-upgrade && apt-get -y install apache2 cpanminus rcs diffutils zip cron make gcc g++ pkg-config libssl-dev libcgi-pm-perl patch
ADD https://downloads.sourceforge.net/project/twiki/TWiki%20for%20all%20Platforms/TWiki-6.1.0/TWiki-6.1.0.tgz TWiki-6.1.0.tgz
RUN tar xfv TWiki-6.1.0.tgz -C /var/www && rm TWiki-6.1.0.tgz

ADD version.patch /tmp/version.patch
RUN patch /var/www/twiki/lib/TWiki/Configure/Checker.pm /tmp/version.patch && rm /tmp/version.patch

ADD cpanfile /tmp/cpanfile
RUN cd /tmp && cpanm -l /var/www/twiki/lib/CPAN --installdeps /tmp/ && rm -rf /.cpanm  /tmp/cpanfile /var/www/twiki/lib/CPAN/man

ADD LocalSite.cfg /var/www/twiki/lib/LocalSite.cfg
RUN chown -cR www-data: /var/www/twiki

ADD twiki.conf /etc/apache2/sites-available/twiki.conf
RUN a2enmod cgi expires && a2dissite '*' && a2ensite twiki.conf

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80