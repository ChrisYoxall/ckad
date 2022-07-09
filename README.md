
Intersting commands to learn!




02 - Architecture

    Set variable for editor to use for kubectl edit: KUBE_EDITOR=vim 

    Auto-complete: 
    
        * Install package bash-completion
        * Do: source <(kubectl completion bash)
        * To always enable: echo "source <(kubectl completion bash)" >> $HOME/.bashrc
    
    Run pod: kubectl run webserver --image=nginx
    
    Create deployment: kubectl create deploy webserver --image=nginx

    Extract yaml (pod example given here): kubectl get pod <pod-name> -o yaml > pod-definition.yaml

    Or get yaml by doing: kubectl run nginx --image=nginx --dry-run=client -o yaml

    Scale deployment: kubectl scale deployment nginx --replicas=4

    Expose pod (pods labels will be used as selector): kubectl expose pod redis --port=6379 --target-port=6379 --name redis-service

    Kubenetes documentation for imperative & declarative management is at https://kubernetes.io/docs/tasks/manage-kubernetes-objects/

    KodeKloud lab on imperative commands at https://kodekloud.com/topic/imperative-commands/

    Handy way to get options for a Kubernetes resource is using explain.  For example: kubectl explain pod --recursive | less

