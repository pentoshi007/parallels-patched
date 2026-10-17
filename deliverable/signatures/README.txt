Entitlement sets used by install.command (it embeds its own copies inline,
these files are for reference / manual re-signing):

  prl_disp_service.entitlements            smartcard only. Used for the
                                           re-signed dispatcher.

  prl_vm_app.reduced.entitlements          {allow-unsigned-executable-memory,
                                           hypervisor}. USE THIS for
                                           prl_vm_app.bin and the
                                           Parallels VM.app reseal.

  prl_vm_app.ORIGINAL-4keys-DO-NOT-SIGN.entitlements
                                           The app's original entitlements.
                                           DO NOT SIGN WITH THESE: the two
                                           vmnet entitlements are
                                           provisioning-gated; a self-signed
                                           binary carrying them is killed by
                                           AMFI at exec (-413).

  prl_client_app.entitlements              Reduced set for the GUI client /
                                           outer bundle reseal (the original
                                           set contains TeamID-restricted
                                           entitlements that do not survive
                                           re-signing and get the process
                                           killed).

General rule: never sign with com.apple.vm.networking,
com.apple.developer.networking.vmnet, application-identifier,
keychain-access-groups, application-groups, team-identifier or
associated-domains on a self-signed (PDLocal) certificate.
