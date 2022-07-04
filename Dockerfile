FROM docker.io/maktup/ace:12.0.4.0-r1

# PLUGIN LOG
RUN mkdir /home/aceuser/ace-server/shared-classes && mkdir /home/aceuser/ace-server/properties

COPY --chown=aceuser:aceuser libs/Log4jLoggingNode_v1.2.4.jar /opt/ibm/ace-12/server/jplugin/
COPY --chown=aceuser:aceuser libs/Log4jLoggingNode_v1.2.4.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/jakarta-oro-2.0.4.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/log4j-1.2.8.jar /home/aceuser/ace-server/shared-classes/

#PLUGIN APM
COPY --chown=aceuser:aceuser libs/apm-agent-api-1.17.0.jar /opt/ibm/ace-12/server/jplugin/
COPY --chown=aceuser:aceuser libs/apm-agent-attach-1.7.0.jar /opt/ibm/ace-12/server/jplugin/
COPY --chown=aceuser:aceuser libs/apm-agent-api-1.17.0.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/apm-agent-attach-1.7.0.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/apm-agent-attach-1.17.0-sources.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/elastic-apm-agent-1.17.0-sources.jar /home/aceuser/ace-server/shared-classes/

#PERMISO jplugin
RUN chmod 755 /opt/ibm/ace-12/server/jplugin/Log4jLoggingNode_v1.2.4.jar \
    &&  chmod 755 /opt/ibm/ace-12/server/jplugin/apm-agent-api-1.17.0.jar \
    && chmod 755 /opt/ibm/ace-12/server/jplugin/apm-agent-attach-1.7.0.jar

#PERMISO shared-classes
RUN chmod 755 /home/aceuser/ace-server/shared-classes/Log4jLoggingNode_v1.2.4.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/jakarta-oro-2.0.4.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/log4j-1.2.8.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/apm-agent-api-1.17.0.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/apm-agent-attach-1.7.0.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/apm-agent-attach-1.17.0-sources.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/elastic-apm-agent-1.17.0-sources.jar

#BASE DE DATOS 
COPY --chown=aceuser:aceuser libs/jt400.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/nzjdbc-1.0.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/ojdbc8.jar /home/aceuser/ace-server/shared-classes/
COPY --chown=aceuser:aceuser libs/sqljdbc42.jar /home/aceuser/ace-server/shared-classes/
RUN chmod 755 /home/aceuser/ace-server/shared-classes/jt400.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/nzjdbc-1.0.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/ojdbc8.jar \
    && chmod 755 /home/aceuser/ace-server/shared-classes/sqljdbc42.jar

#APIDB
COPY --chown=aceuser:aceuser bars/APIDB_DB2_PROCEDURE.bar /home/aceuser/initial-config/bars/
COPY --chown=aceuser:aceuser bars/APIDB_DB2_QUERY.bar /home/aceuser/initial-config/bars/
COPY --chown=aceuser:aceuser bars/APIDB_NETEZZA_PROCEDURE.bar /home/aceuser/initial-config/bars/
COPY --chown=aceuser:aceuser bars/APIDB_NETEZZA_QUERY.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_ORACLE_PROCEDURE.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_ORACLE_QUERY.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_SQLSERVER_PROCEDURE.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_SQLSERVER_QUERY.bar /home/aceuser/initial-config/bars/

#APIDBv2
#COPY --chown=aceuser:aceuser bars/APIDB_SQLSERVER_PROCEDURE_V2.bar /home/aceuser/initial-config/bars/

COPY --chown=aceuser:aceuser properties/apidb.properties /home/aceuser/ace-server/properties

#DATAQUEUE
#COPY --chown=aceuser:aceuser bars/APIDB_DATAQUEUE.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_DATAQUEUE_ERROR_TRANSIENT.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_DATAQUEUE_ERROR_NO_TRANSIENT.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_CALL_DATAQUEUE_ERROR_TRANSIENT.bar /home/aceuser/initial-config/bars/
#COPY --chown=aceuser:aceuser bars/APIDB_CALL_DATAQUEUE_ERROR_NO_TRANSIENT.bar /home/aceuser/initial-config/bars/

#CONFIG LOG
COPY --chown=aceuser:aceuser config/confLogApiDB.xml /var/mqsi/config/

USER root
#RUTA GUARDAR LOGS
RUN mkdir -p /apps/logs \
    && chmod +x /apps/logs* \
    && chmod 777 /apps/logs* \
    && chown aceuser:aceuser /apps/logs

USER aceuser