import test from 'node:test';
import assert from 'node:assert/strict';
import { buildAudit } from '../src/utils/audit.js';

test('buildAudit returns expected structure', () => {
  const entry = buildAudit({ action: 'authorize_payment', targetUserId: 'u1', targetEmail: 'a@b', adminId: 'admin1', details: 'details' });
  assert.equal(entry.action, 'authorize_payment');
  assert.equal(entry.targetUserId, 'u1');
  assert.equal(entry.targetEmail, 'a@b');
  assert.equal(entry.adminId, 'admin1');
  assert.equal(entry.details, 'details');
  assert.ok(entry.createdAt);
});
