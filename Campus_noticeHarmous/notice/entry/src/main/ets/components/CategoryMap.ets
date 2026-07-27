// 分类中文标签列表（分类栏直接复用）
export const categoryLabelList: string[] = ["全部", "通知", "行政", "学术"];

/**
 * 中文分类转后端真实字段
 * @param label 中文分类名
 * @returns 后端对应英文枚举
 */
export function getRealCategory(label: string): string {
  switch (label) {
    case "通知":
      return "NOTICE";
    case "行政":
      return "ADMIN";
    case "学术":
      return "ACADEMIC";
    default:
      return "";
  }
}

/**
 * 后端英文字段转回中文（详情页展示分类用）
 * @param realKey 后端英文枚举
 * @returns 中文分类名
 */
export function getCategoryLabel(realKey: string): string {
  switch (realKey) {
    case "NOTICE":
      return "通知";
    case "ADMIN":
      return "行政";
    case "ACADEMIC":
      return "学术";
    default:
      return "全部";
  }
}