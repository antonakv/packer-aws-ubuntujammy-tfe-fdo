# packer-aws-ubuntujammy-tfe-fdo
Packer build of Ubuntu Jammy AMI image

## Intro
This manual is dedicated to create AWS image with Ubuntu Jammy for TFE FDO docker compose

- Change folder to packer-aws-ubuntujammy-tfe-fdo

```bash
cd packer-aws-ubuntujammy-tfe-fdo
```

## Build
- In the same folder you were before run 

```bash
packer init template.pkr.hcl
packer build template.pkr.hcl
```
