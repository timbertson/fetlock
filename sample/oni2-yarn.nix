{ fetchurl, fetchgit, linkFarm, runCommandNoCC, gnutar }: rec {
  offline_cache = linkFarm "offline" packages;
  packages = [
    {
      name = "_onivim_vscode_exthost___vscode_exthost_1.52.1000.tgz";
      path = fetchurl {
        name = "_onivim_vscode_exthost___vscode_exthost_1.52.1000.tgz";
        url  = "https://registry.yarnpkg.com/@onivim/vscode-exthost/-/vscode-exthost-1.52.1000.tgz";
        sha1 = "f69523da388b9595662ff12c600fe5fe0c2150ae";
      };
    }
    {
      name = "agent_base___agent_base_4.3.0.tgz";
      path = fetchurl {
        name = "agent_base___agent_base_4.3.0.tgz";
        url  = "https://registry.yarnpkg.com/agent-base/-/agent-base-4.3.0.tgz";
        sha1 = "8165f01c436009bccad0b1d122f05ed770efc6ee";
      };
    }
    {
      name = "bindings___bindings_1.5.0.tgz";
      path = fetchurl {
        name = "bindings___bindings_1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/bindings/-/bindings-1.5.0.tgz";
        sha1 = "10353c9e945334bc0511a6d90b38fbc7c9c504df";
      };
    }
    {
      name = "buffer_crc32___buffer_crc32_0.2.13.tgz";
      path = fetchurl {
        name = "buffer_crc32___buffer_crc32_0.2.13.tgz";
        url  = "https://registry.yarnpkg.com/buffer-crc32/-/buffer-crc32-0.2.13.tgz";
        sha1 = "0d333e3f00eac50aa1454abd30ef8c2a5d9a7242";
      };
    }
    {
      name = "debug___debug_3.2.6.tgz";
      path = fetchurl {
        name = "debug___debug_3.2.6.tgz";
        url  = "https://registry.yarnpkg.com/debug/-/debug-3.2.6.tgz";
        sha1 = "e83d17de16d8a7efb7717edbe5fb10135eee629b";
      };
    }
    {
      name = "es6_promise___es6_promise_4.2.8.tgz";
      path = fetchurl {
        name = "es6_promise___es6_promise_4.2.8.tgz";
        url  = "https://registry.yarnpkg.com/es6-promise/-/es6-promise-4.2.8.tgz";
        sha1 = "4eb21594c972bc40553d276e510539143db53e0a";
      };
    }
    {
      name = "es6_promisify___es6_promisify_5.0.0.tgz";
      path = fetchurl {
        name = "es6_promisify___es6_promisify_5.0.0.tgz";
        url  = "https://registry.yarnpkg.com/es6-promisify/-/es6-promisify-5.0.0.tgz";
        sha1 = "5109d62f3e56ea967c4b63505aef08291c8a5203";
      };
    }
    {
      name = "fd_slicer___fd_slicer_1.1.0.tgz";
      path = fetchurl {
        name = "fd_slicer___fd_slicer_1.1.0.tgz";
        url  = "https://registry.yarnpkg.com/fd-slicer/-/fd-slicer-1.1.0.tgz";
        sha1 = "25c7c89cb1f9077f8891bbe61d8f390eae256f1e";
      };
    }
    {
      name = "file_uri_to_path___file_uri_to_path_1.0.0.tgz";
      path = fetchurl {
        name = "file_uri_to_path___file_uri_to_path_1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/file-uri-to-path/-/file-uri-to-path-1.0.0.tgz";
        sha1 = "553a7b8446ff6f684359c445f1e37a05dacc33dd";
      };
    }
    {
      name = "follow_redirects___follow_redirects_1.13.0.tgz";
      path = fetchurl {
        name = "follow_redirects___follow_redirects_1.13.0.tgz";
        url  = "https://registry.yarnpkg.com/follow-redirects/-/follow-redirects-1.13.0.tgz";
        sha1 = "b42e8d93a2a7eea5ed88633676d6597bc8e384db";
      };
    }
    {
      name = "fs_extra___fs_extra_8.1.0.tgz";
      path = fetchurl {
        name = "fs_extra___fs_extra_8.1.0.tgz";
        url  = "https://registry.yarnpkg.com/fs-extra/-/fs-extra-8.1.0.tgz";
        sha1 = "49d43c45a88cd9677668cb7be1b46efdb8d2e1c0";
      };
    }
    {
      name = "graceful_fs___graceful_fs_4.1.11.tgz";
      path = fetchurl {
        name = "graceful_fs___graceful_fs_4.1.11.tgz";
        url  = "https://registry.yarnpkg.com/graceful-fs/-/graceful-fs-4.1.11.tgz";
        sha1 = "0e8bdfe4d1ddb8854d64e04ea7c00e2a026e5658";
      };
    }
    {
      name = "http_proxy_agent___http_proxy_agent_2.1.0.tgz";
      path = fetchurl {
        name = "http_proxy_agent___http_proxy_agent_2.1.0.tgz";
        url  = "https://registry.yarnpkg.com/http-proxy-agent/-/http-proxy-agent-2.1.0.tgz";
        sha1 = "e4821beef5b2142a2026bd73926fe537631c5405";
      };
    }
    {
      name = "https_proxy_agent___https_proxy_agent_2.2.4.tgz";
      path = fetchurl {
        name = "https_proxy_agent___https_proxy_agent_2.2.4.tgz";
        url  = "https://registry.yarnpkg.com/https-proxy-agent/-/https-proxy-agent-2.2.4.tgz";
        sha1 = "4ee7a737abd92678a293d9b34a1af4d0d08c787b";
      };
    }
    {
      name = "iconv_lite_umd___iconv_lite_umd_0.6.8.tgz";
      path = fetchurl {
        name = "iconv_lite_umd___iconv_lite_umd_0.6.8.tgz";
        url  = "https://registry.yarnpkg.com/iconv-lite-umd/-/iconv-lite-umd-0.6.8.tgz";
        sha1 = "5ad310ec126b260621471a2d586f7f37b9958ec0";
      };
    }
    {
      name = "ip___ip_1.1.5.tgz";
      path = fetchurl {
        name = "ip___ip_1.1.5.tgz";
        url  = "https://registry.yarnpkg.com/ip/-/ip-1.1.5.tgz";
        sha1 = "bdded70114290828c0a039e72ef25f5aaec4354a";
      };
    }
    {
      name = "jsonfile___jsonfile_4.0.0.tgz";
      path = fetchurl {
        name = "jsonfile___jsonfile_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/jsonfile/-/jsonfile-4.0.0.tgz";
        sha1 = "8771aae0799b64076b76640fca058f9c10e33ecb";
      };
    }
    {
      name = "minimist___minimist_1.2.5.tgz";
      path = fetchurl {
        name = "minimist___minimist_1.2.5.tgz";
        url  = "https://registry.yarnpkg.com/minimist/-/minimist-1.2.5.tgz";
        sha1 = "67d66014b66a6a8aaa0c083c5fd58df4e4e97602";
      };
    }
    {
      name = "mkdirp___mkdirp_0.5.5.tgz";
      path = fetchurl {
        name = "mkdirp___mkdirp_0.5.5.tgz";
        url  = "https://registry.yarnpkg.com/mkdirp/-/mkdirp-0.5.5.tgz";
        sha1 = "d91cefd62d1436ca0f41620e251288d420099def";
      };
    }
    {
      name = "ms___ms_2.1.2.tgz";
      path = fetchurl {
        name = "ms___ms_2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/ms/-/ms-2.1.2.tgz";
        sha1 = "d09d1f357b443f493382a8eb3ccd183872ae6009";
      };
    }
    {
      name = "nan___nan_2.14.1.tgz";
      path = fetchurl {
        name = "nan___nan_2.14.1.tgz";
        url  = "https://registry.yarnpkg.com/nan/-/nan-2.14.1.tgz";
        sha1 = "d7be34dfa3105b91494c3147089315eff8874b01";
      };
    }
    {
      name = "native_watchdog___native_watchdog_1.3.0.tgz";
      path = fetchurl {
        name = "native_watchdog___native_watchdog_1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/native-watchdog/-/native-watchdog-1.3.0.tgz";
        sha1 = "88cee94c9dc766b85c8506eda14c8bd8c9618e27";
      };
    }
    {
      name = "node_pty___node_pty_0.10.0_beta9.tgz";
      path = fetchurl {
        name = "node_pty___node_pty_0.10.0_beta9.tgz";
        url  = "https://registry.yarnpkg.com/node-pty/-/node-pty-0.10.0-beta9.tgz";
        sha1 = "e5a795f9b53948346803cb71bac4ffc02e7909f0";
      };
    }
    {
      name = "pend___pend_1.2.0.tgz";
      path = fetchurl {
        name = "pend___pend_1.2.0.tgz";
        url  = "https://registry.yarnpkg.com/pend/-/pend-1.2.0.tgz";
        sha1 = "7a57eb550a6783f9115331fcf4663d5c8e007a50";
      };
    }
    {
      name = "semver_umd___semver_umd_5.5.7.tgz";
      path = fetchurl {
        name = "semver_umd___semver_umd_5.5.7.tgz";
        url  = "https://registry.yarnpkg.com/semver-umd/-/semver-umd-5.5.7.tgz";
        sha1 = "966beb5e96c7da6fbf09c3da14c2872d6836c528";
      };
    }
    {
      name = "smart_buffer___smart_buffer_4.1.0.tgz";
      path = fetchurl {
        name = "smart_buffer___smart_buffer_4.1.0.tgz";
        url  = "https://registry.yarnpkg.com/smart-buffer/-/smart-buffer-4.1.0.tgz";
        sha1 = "91605c25d91652f4661ea69ccf45f1b331ca21ba";
      };
    }
    {
      name = "socks_proxy_agent___socks_proxy_agent_4.0.2.tgz";
      path = fetchurl {
        name = "socks_proxy_agent___socks_proxy_agent_4.0.2.tgz";
        url  = "https://registry.yarnpkg.com/socks-proxy-agent/-/socks-proxy-agent-4.0.2.tgz";
        sha1 = "3c8991f3145b2799e70e11bd5fbc8b1963116386";
      };
    }
    {
      name = "socks___socks_2.3.3.tgz";
      path = fetchurl {
        name = "socks___socks_2.3.3.tgz";
        url  = "https://registry.yarnpkg.com/socks/-/socks-2.3.3.tgz";
        sha1 = "01129f0a5d534d2b897712ed8aceab7ee65d78e3";
      };
    }
    {
      name = "spdlog___spdlog_0.11.1.tgz";
      path = fetchurl {
        name = "spdlog___spdlog_0.11.1.tgz";
        url  = "https://registry.yarnpkg.com/spdlog/-/spdlog-0.11.1.tgz";
        sha1 = "29721b31018a5fe6a3ce2531f9d8d43e0bd6b825";
      };
    }
    {
      name = "sudo_prompt___sudo_prompt_9.0.0.tgz";
      path = fetchurl {
        name = "sudo_prompt___sudo_prompt_9.0.0.tgz";
        url  = "https://registry.yarnpkg.com/sudo-prompt/-/sudo-prompt-9.0.0.tgz";
        sha1 = "eebedeee9fcd6f661324e6bb46335e3288e8dc8a";
      };
    }
    {
      name = "universalify___universalify_0.1.2.tgz";
      path = fetchurl {
        name = "universalify___universalify_0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/universalify/-/universalify-0.1.2.tgz";
        sha1 = "b646f69be3942dabcecc9d6639c80dc105efaa66";
      };
    }
    {
      name = "vscode_proxy_agent___vscode_proxy_agent_0.5.2.tgz";
      path = fetchurl {
        name = "vscode_proxy_agent___vscode_proxy_agent_0.5.2.tgz";
        url  = "https://registry.yarnpkg.com/vscode-proxy-agent/-/vscode-proxy-agent-0.5.2.tgz";
        sha1 = "0c90d24d353957b841d741da7b2701e3f0a044c4";
      };
    }
    {
      name = "vscode_regexpp___vscode_regexpp_3.1.0.tgz";
      path = fetchurl {
        name = "vscode_regexpp___vscode_regexpp_3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/vscode-regexpp/-/vscode-regexpp-3.1.0.tgz";
        sha1 = "42d059b6fffe99bd42939c0d013f632f0cad823f";
      };
    }
    {
      name = "yauzl___yauzl_2.10.0.tgz";
      path = fetchurl {
        name = "yauzl___yauzl_2.10.0.tgz";
        url  = "https://registry.yarnpkg.com/yauzl/-/yauzl-2.10.0.tgz";
        sha1 = "c7eb17c93e112cb1086fa6d8e51fb0667b79a5f9";
      };
    }
  ];
}
