#!/bin/bash
echo url="https://www.duckdns.org/update?domains=grabler&token=47c962de-7e3d-46df-986f-103e844ff32b&ip=" | curl -k -o ~/duckdns.log -K -
