export function isAccessRestricted(role) {
  return role === 'blocked' || role === 'revoked';
}

export function getAccessStateLabel(role) {
  if (role === 'admin') return 'Admin';
  if (role === 'active') return 'Ativo';
  if (role === 'revoked') return 'Acesso revogado';
  if (role === 'blocked') return 'Bloqueado';
  if (role === 'pending') return 'Pendente';
  return 'Pendente';
}
