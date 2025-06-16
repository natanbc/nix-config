{
  services.k3s.settings = {
    kube-apiserver-arg = [
      "oidc-issuer-url=https://idp.x86-64.mov/oauth2/openid/kubernetes"
      "oidc-client-id=kubernetes"
      "oidc-username-claim=email"
      "oidc-groups-claim=groups"
      "oidc-signing-algs=ES256"
      "oidc-groups-prefix=oidc:"
    ];
  };
}
