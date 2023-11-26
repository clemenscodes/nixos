{pkgs}:
pkgs.writeShellScriptBin "nvidiagpuinfo" ''
  # Check for NVIDIA GPU using nvidia-smi
  nvidia_gpu=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader,nounits | head -n 1)

  # Check if primary GPU is NVIDIA
  if [ -n "$nvidia_gpu" ]; then
    # if nvidia-smi failed, format and exit.
    if [[ $nvidia_gpu == *"NVIDIA-SMI has failed"* ]]; then
      # Print the formatted information in JSON
      echo "{\"text\":\"N/A\", \"tooltip\":\"Primary GPU: Not found\"}"
      exit 0
    fi

    # Collect GPU information for NVIDIA
    gpu_info=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,clocks.current.graphics,clocks.max.graphics,power.draw,power.max_limit --format=csv,noheader,nounits)
    # Split the comma-separated values into an array
    IFS=',' read -ra gpu_data <<< "$gpu_info"
    # Extract individual values
    temperature="''${gpu_data[0]// /}"
    utilization="''${gpu_data[1]// /}"
    current_clock_speed="''${gpu_data[2]// /}"
    max_clock_speed="''${gpu_data[3]// /}"
    power_usage="''${gpu_data[4]// /}"
    power_limit="''${gpu_data[5]// /}"

    # Print the formatted information in JSON
    echo "{\"text\":\"$temperature°C\", \"tooltip\":\"Primary GPU: $nvidia_gpu\n󰾆  Utilization: $utilization%\n  Clock Speed: $current_clock_speed/$max_clock_speed MHz\n  Power Usage: $power_usage/$power_limit W\"}"
  fi
''
