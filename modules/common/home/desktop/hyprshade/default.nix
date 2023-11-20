{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      hyprshade
    ];
  };
  xdg = {
    configFile = {
      "hyprshade/config.toml" = {
        text = ''
          [[shades]]
          name = "vibrance"
          default = true
          
          [[shades]]
          name = "blue-light-filter"
          start_time = 19:00:00
          end_time = 06:00:00
        '';
      };
      "hypr/shaders/blue-light-filter.glsl" = {
        text = ''
          precision mediump float;
          varying vec2 v_texcoord;
          uniform sampler2D tex;
          const float temperature = 2600.0;
          const float temperatureStrength = 1.0;
          #define WithQuickAndDirtyLuminancePreservation
          const float LuminancePreservationFactor = 1.0;
          vec3 colorTemperatureToRGB(const in float temperature){
              mat3 m = (temperature <= 6500.0) ? mat3(vec3(0.0, -2902.1955373783176, -8257.7997278925690),
                                                      vec3(0.0, 1669.5803561666639, 2575.2827530017594),
                                                      vec3(1.0, 1.3302673723350029, 1.8993753891711275)) :
                                                 mat3(vec3(1745.0425298314172, 1216.6168361476490, -8257.7997278925690),
                                                      vec3(-2666.3474220535695, -2173.1012343082230, 2575.2827530017594),
                                                      vec3(0.55995389139931482, 0.70381203140554553, 1.8993753891711275));
              return mix(
                  clamp(vec3(m[0] / (vec3(clamp(temperature, 1000.0, 40000.0)) + m[1]) + m[2]), vec3(0.0), vec3(1.0)),
                  vec3(1.0),
                  smoothstep(1000.0, 0.0, temperature)
              );
          }
          void main() {
              vec4 pixColor = texture2D(tex, v_texcoord);
              vec3 color = vec3(pixColor[0], pixColor[1], pixColor[2]);
          #ifdef WithQuickAndDirtyLuminancePreservation
              color *= mix(1.0,
                           dot(color, vec3(0.2126, 0.7152, 0.0722)) / max(dot(color, vec3(0.2126, 0.7152, 0.0722)), 1e-5),
                           LuminancePreservationFactor);
          #endif
              color = mix(color, color * colorTemperatureToRGB(temperature), temperatureStrength);
              vec4 outCol = vec4(color, pixColor[3]);
              gl_FragColor = outCol;
          }
        '';
      };
      "hypr/shaders/vibrance.glsl" = {
        text = ''
          precision mediump float;
          varying vec2 v_texcoord;
          uniform sampler2D tex;
          const vec3 VIB_RGB_BALANCE = vec3(1.0, 1.0, 1.0);
          const float VIB_VIBRANCE = 0.15;
          const vec3 VIB_coeffVibrance = VIB_RGB_BALANCE * -VIB_VIBRANCE;
          void main() {
              vec4 pixColor = texture2D(tex, v_texcoord);
              vec3 color = vec3(pixColor[0], pixColor[1], pixColor[2]);
              vec3 VIB_coefLuma = vec3(0.212656, 0.715158, 0.072186); // try both and see which one looks nicer.
              float luma = dot(VIB_coefLuma, color);
              float max_color = max(color[0], max(color[1], color[2]));
              float min_color = min(color[0], min(color[1], color[2]));
              float color_saturation = max_color - min_color;
              vec3 p_col = vec3(vec3(vec3(vec3(sign(VIB_coeffVibrance) * color_saturation) - 1.0) * VIB_coeffVibrance) + 1.0);
              pixColor[0] = mix(luma, color[0], p_col[0]);
              pixColor[1] = mix(luma, color[1], p_col[1]);
              pixColor[2] = mix(luma, color[2], p_col[2]);
              gl_FragColor = pixColor;
          }
        '';
      };
    };
  };
}
