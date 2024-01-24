let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILt3S04iJgypib/BxGbxRXaBaZhpimuHePiytxbqiGYy natan@nixos"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWklwVJt7o3nGDTrRzK7AVQVifGORo/hzmP2EiT8v75 natan@mia3"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN/hJrX3BFTa1jXdo02wM/O5ZrrO5f6Lj4/Os1Vxx87Q natan@laptop"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5w/yPd34ThyeUSCt3o5bfy2DezExYgLACoul0pOsfY natan@iphone-14"
  ];
in {
  root = keys;  
}

