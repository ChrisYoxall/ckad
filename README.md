
Intersting commands to learn!


General Stuff:

    Set variable for editor to use for kubectl edit: KUBE_EDITOR=vim 

    Auto-complete: 
    
        * Install package bash-completion
        * Do: source <(kubectl completion bash)
        * To always enable: echo "source <(kubectl completion bash)" >> $HOME/.bashrc


Commands: 

    - Kubenetes documentation for imperative & declarative management is at https://kubernetes.io/docs/tasks/manage-kubernetes-objects/

    - KodeKloud lab on imperative commands at https://kodekloud.com/topic/imperative-commands/

    - Handy way to get options for a Kubernetes resource is using explain.  For example: kubectl explain pod --recursive | less

    
    Run pod: kubectl run webserver --image=nginx

    Run pod and execute command: kubectl run busybox --image=busybox --command -- env 
    
    Create deployment: kubectl create deploy webserver --image=nginx

    Extract yaml (pod example given here): kubectl get pod <pod-name> -o yaml > pod-definition.yaml

    Or get yaml by doing: kubectl run nginx --image=nginx --dry-run=client -o yaml

    Scale deployment: kubectl scale deployment nginx --replicas=4

    Expose pod (pods labels will be used as selector): kubectl expose pod redis --port=6379 --target-port=6379 --name redis-service

    Doing a 'kubectl set' allows some existing application resources (image, environment, resources etc.) to be update

       
    Search based on label: kubectl get po --selector app=db    Group multiple selectors using commas.

    Get status, history etc on rollouts: kubectl rollout status daemonset/foo


    Create role: kubectl create role developer --namespace=default --verb=list,create,delete --resource=pods

    Create rolebinding: kubectl create rolebinding dev-user-binding --namespace=default --role=developer --user=dev-user

    Check Access via 'auth':

        Check to see if you can get pods: kubectl auth can-i get pods
        Check if certain user can get pods: kubectl auth can-i get pods --as dev-user



Accessing API:

    The kubeconfig has the certs in Base64 encoded format. Can decode and put on disk and referene them from kubeconfig using different key.

    Once the certs are out (as per last step) can call API via curl and passing in '--key', '--cert' and 'cacert'

    Refer https://iximiuz.com/en/posts/kubernetes-api-call-simple-http-client/ and https://nieldw.medium.com/curling-the-kubernetes-api-server-d7675cfc398c

    Increasing the verbosity high enough shows the API calls made when using 'kubectl'





kubectl run busybox --image=busybox --restart=Never --command -- env 
