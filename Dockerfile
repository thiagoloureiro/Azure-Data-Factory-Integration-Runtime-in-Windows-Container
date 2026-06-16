FROM mcr.microsoft.com/windows/servercore:ltsc2022
ARG INSTALL_JDK=true
ARG INSTALL_CERT=true

# Download the latest self-hosted integration runtime installer into the SHIR folder
COPY SHIR C:/SHIR/

RUN ["powershell", "C:/SHIR/build.ps1"]

ENTRYPOINT ["powershell", "C:/SHIR/setup.ps1"]

ENV SHIR_WINDOWS_CONTAINER_ENV True
ENV ENABLE_HA True
ENV ENABLE_AE True

HEALTHCHECK --start-period=120s CMD ["powershell", "C:/SHIR/health-check.ps1"]
