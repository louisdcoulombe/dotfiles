alias k=kubectl

alias s_getpod="kubectl -n solid get pods --show-labels=true"
alias s_fwdclient="kubectl -n solid port-forward service/terminal-client 8080:8080"
alias s_fwdserver="kubectl -n solid port-forward service/neo4j 7474:7474 7687:7687"

alias s_logclient="kubectl -n solid logs -f -l app.kubernetes.io/name=terminal-client"
alias s_logserver="kubectl -n solid logs -f -l app=terminal-server"
alias s_logcs-client="kubectl -n solid logs -f -l app=cs-client"
alias s_logcs-server="kubectl -n solid logs -f -l app=cs-server"
alias s_log-miner="kubectl -n solid logs -f -l app=terminal-miner"

alias s_uninst="helm uninstall -n solid --wait solid"
alias s_delete="helm delete -n solid solid --wait"
