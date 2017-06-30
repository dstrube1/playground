DEL L:\Common\EproLibNET\*.* /F /Q

COPY C:\VSProjects\EproLibNET\AttachmentManagement\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\EPImageControl\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\EPImageUtil\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\EPImageViewer\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\EPImageViewerApp\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\EproDB\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\EproLibNET\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\FTPAccess\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\ProgressBars\bin\Release\*.* L:\Common\EproLibNET
COPY C:\VSProjects\EproLibNET\Purge\bin\Release\*.* L:\Common\EproLibNET

DEL L:\Common\EproLibNET\Atalasoft.dotImage* /F /Q

DEL C:\EproLibNET\*.* /F /Q

COPY L:\Common\EproLibNET\*.* C:\EproLibNET

PAUSE