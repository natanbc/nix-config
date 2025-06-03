{ nixosConfig, ... }:
{
  programs.htop = {
    enable = true;
    settings = {
      enable_mouse = 1;
      hide_kernel_threads = 0;
      hide_userland_threads = 1;
      highlight_base_name = 1;
      show_thread_names = 1;
      show_program_path = 1;
      tree_view = 1;
    } // (if nixosConfig.boot.isContainer then {} else {
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    });
  };
}
