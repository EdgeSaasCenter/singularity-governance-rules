const fs = require('fs');
const path = require('path');
const rulesDir = path.join(__dirname, '..', 'rules');

const requiredRules = [
  'density_contract.md',
  'atomic_execution.md',
  'model_failover_resilience.md',
  'singularity_maturity.md',
  'no_stop_hook.md',
  'context_savepoint.md',
  'AGENTS.md'
];

for (const rule of requiredRules) {
  const p = path.join(rulesDir, rule);
  if (!fs.existsSync(p)) {
    console.error('FAIL: Missing rule ' + rule);
    process.exit(1);
  }
}
console.log('PASS: All 7 Singularity Governance Rules present and verified ✓');
