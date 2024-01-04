export const timeUtil = (content: string) => {
  const date = new Date(content);
  let y = date.getFullYear();
  let m = date.getMonth() + 1;
  let d = date.getDate();
  let h = date.getHours();
  let mi = date.getMinutes();
  return `${y}-${m < 10 ? '0' + m : m}-${d < 10 ? '0' + d : d} ${h}:${mi}`;
}