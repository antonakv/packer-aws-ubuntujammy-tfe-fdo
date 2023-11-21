packer {
  required_plugins {
    amazon = {
      version = "~> 1.2.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-aws-ubuntujammy-tfe-fdo-10"
  instance_type = "t3.large"
  region        = "eu-north-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-*-amd64-server-**"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["679593333241"] # Cannonical Limited ltd.
  }
  ssh_username = "ubuntu"
  aws_polling {
    delay_seconds = 120
    max_attempts  = 60
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = "1"
    http_tokens                 = "required"
  }
  imds_support = "v2.0"
}

build {
  name    = "ubuntujammy-tfe"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    execute_command = "sudo -S env {{ .Vars }} {{ .Path }}"
    script = "scripts/packages.sh"
  }
}
