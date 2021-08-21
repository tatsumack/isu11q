#!/bin/bash
set -ex

LOG_DIR=/home/isucon/log
mkdir -p ${LOG_DIR}

# alp
if [ -f ${LOG_DIR}/alp.log ]; then
    sudo mv ${LOG_DIR}/alp.log ${LOG_DIR}/alp.log.$(date "+%Y%m%d_%H%M%S")
fi
sudo /usr/local/bin/alp -f /var/log/nginx/access.log --sum -r  --aggregates='/isu/.*/graph,/api/condition/.*,/api/isu/.*/icon,/isu/.*/condition,/api/isu/[a-f0-9\-],/isu/[a-f0-9\-]' > ${LOG_DIR}/alp.log

# slow query
if [ -f ${LOG_DIR}/mysql-slow-query.log ]; then
    sudo mv ${LOG_DIR}/mysql-slow-query.log ${LOG_DIR}/mysql-slow-query.log.$(date "+%Y%m%d_%H%M%S")
fi
sudo /usr/local/bin/pt-query-digest /var/log/mysql/mysql-slow.log > ${LOG_DIR}/mysql-slow-query.log
