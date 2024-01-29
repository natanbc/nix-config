{
  services.nginx.commonHttpConfig = ''
    set_real_ip_from 127.0.0.1/8;
    set_real_ip_from ::1/128;
    real_ip_header CF-Connecting-IP;
  '';
}
