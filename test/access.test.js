import test from 'node:test';
import assert from 'node:assert/strict';
import { isAccessRestricted, getAccessStateLabel } from '../src/utils/access.js';

test('revoked access is treated as restricted and labeled semantically', () => {
  assert.equal(isAccessRestricted('revoked'), true);
  assert.equal(isAccessRestricted('active'), false);
  assert.equal(getAccessStateLabel('revoked'), 'Acesso revogado');
  assert.equal(getAccessStateLabel('blocked'), 'Bloqueado');
});
