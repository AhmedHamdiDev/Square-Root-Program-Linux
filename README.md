# x64 Assembly Square Root Program for Linux

This is an educational, hands-on project designed to demonstrate **SIMD registers and instructions** in x64 assembly.  
⚠️ Note: This project uses **only Linux syscalls and SIMD logic** — no external C libraries are used.

---

## Linux

Execute the following commands. Your machine must be x64 Linux:

```bash
git clone https://github.com/AhmedHamdiDev/Square-Root-Program-Linux
cd Square-Root-Program-Linux
chmod +x calcsqrt
./calcsqrt
```

## Windows (Via WSL)

1.Ensure Virtualization is enabled in BIOS and turn on Virtual Machine Platform and Windows Subsystem for Linux (WSL) from Windows Features.

2.Install WSL and a Linux distribution (Ubuntu recommended):

```powershell
wsl --install ubuntu
```

3.Launch WSL:

```powershell
wsl
```

4.Install Git inside WSL:

```bash
sudo apt install git
```

5.Then, follow the Linux instructions above to clone and run the program.


Feel free to examine my code and learn how it works 
