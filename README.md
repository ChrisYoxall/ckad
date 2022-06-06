
Intersting commands to learn!


02 - Architecture

    Set variable for editor to use for kubectl edit: KUBE_EDITOR=vim 

    Auto-complete: 
    
        * Install package bash-completion
        * Do: source <(kubectl completion bash)
        * To always enable: echo "source <(kubectl completion bash)" >> $HOME/.bashrc
    
    Create pod: kubectl create deploy test1 --image=nginx
