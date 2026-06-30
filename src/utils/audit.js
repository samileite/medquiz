export function buildAudit({ action, targetUserId, targetEmail, adminId, details }) {
  return {
    action,
    targetUserId: targetUserId || null,
    targetEmail: targetEmail || null,
    adminId: adminId || null,
    details: details || null,
    createdAt: new Date().toISOString(),
  };
}

export default buildAudit;
