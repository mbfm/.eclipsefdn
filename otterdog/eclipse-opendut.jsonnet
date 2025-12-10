local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('automotive.opendut', 'eclipse-opendut') {
  settings+: {
    name: "Eclipse openDuT",
    description: "Test Electronic Control Units around the world in a transparent network.",
    discussion_source_repository: "eclipse-opendut/opendut",
    has_discussions: true,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('.github') {
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('opendut') {
      delete_branch_on_merge: false,
      description: "Test Electronic Control Units around the world in a transparent network.",
      has_discussions: true,
      has_wiki: false,
      homepage: "https://opendut.eclipse.dev",
      gh_pages_build_type: "workflow",
      topics+: [
        "automotive"
      ],
      web_commit_signoff_required: false,
      variables: [
        orgs.newRepoVariable('OPENDUT_GH_RUNNER_LARGE') {
          value: "[\"ubuntu-latest\"]",
        },
        orgs.newRepoVariable('OPENDUT_GH_RUNNER_SMALL') {
          value: "[\"ubuntu-latest\"]",
        },
        orgs.newRepoVariable('OPENDUT_RUN_TESTENV') {
          value: "false",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 1,
          required_status_checks+: [
            "status-check"
          ],
          requires_conversation_resolution: true,
        },
      ],
      rulesets: [
        orgs.newRepoRuleset('protect-development-branch') {
          allows_force_pushes: true,
          include_refs+: [
            "refs/heads/development"
          ],
          required_pull_request: null,
          required_status_checks: null,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main",
            "development",
            "tag:v[0-9].[0-9].[0-9]",
            "tag:v[0-9].[0-9].[0-9]-*",
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('raspberry-pi-wireless-bootstrap') {
      delete_branch_on_merge: false,
      description: "Easily configure your Raspberry Pi from scratch via WiFi hotspot.",
      has_wiki: false,
      topics+: [
        "raspberry-pi"
      ],
      web_commit_signoff_required: false,
    },
    orgs.newRepo('cannelloni-build') {
      aliases: ["cannelloni"],
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      description: "Build cannelloni for multiple architectures.",
      has_wiki: false,
      homepage: "https://github.com/mguentner/cannelloni",
    },
    orgs.newRepo('netbird-fork') {
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      description: "Netbird with adjustments for openDuT.",
      forked_repository: "netbirdio/netbird",
      fork_default_branch_only: true,
      has_wiki: false,
      homepage: "https://netbird.io",
    },
    orgs.newRepo('netbird-build') {
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      description: "Build Netbird for multiple architectures.",
      has_wiki: false,
      homepage: "https://netbird.io",
    },
    orgs.newRepo('rperf-build') {
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      description: "Build rperf for multiple architectures.",
      has_wiki: false,
      homepage: "https://github.com/opensource-3d-p/rperf",
    },
  ],
}
