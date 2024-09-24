{ pkgs, ... }:
let
  yaml = pkgs.formats.yaml {};
  path = yaml.generate "kubelet.config" {
    apiVersion = "kubelet.config.k8s.io/v1beta1";
    kind = "KubeletConfiguration";
    maxPods = 1020;
  };
in
{
  services.k3s.flags = [
    "--kubelet-arg=config=${path}"
  ];
}
