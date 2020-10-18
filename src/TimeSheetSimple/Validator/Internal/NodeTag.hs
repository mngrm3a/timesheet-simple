module TimeSheetSimple.Validator.Internal.NodeTag where

import CMarkGFM (NodeType (..))

data NodeTag
  = Document
  | ThematicBreak
  | Paragraph
  | BlockQuote
  | HtmlBlock
  | CustomBlock
  | CodeBlock
  | Heading
  | List
  | Item
  | Text_
  | SoftBreak
  | LineBreak
  | HtmlInline
  | CustomInline
  | Code
  | Emphasis
  | Strong
  | Link
  | Image
  | StrikeThrough
  | Table
  | TableRow
  | TableCell
  deriving (Eq, Show, Read)

mkNodeTag :: NodeType -> NodeTag
mkNodeTag DOCUMENT = Document
mkNodeTag THEMATIC_BREAK = ThematicBreak
mkNodeTag PARAGRAPH = Paragraph
mkNodeTag BLOCK_QUOTE = BlockQuote
mkNodeTag (HTML_BLOCK _) = HtmlBlock
mkNodeTag (CUSTOM_BLOCK _ _) = CustomBlock
mkNodeTag (CODE_BLOCK _ _) = CodeBlock
mkNodeTag (HEADING _) = Heading
mkNodeTag (LIST _) = List
mkNodeTag ITEM = Item
mkNodeTag (TEXT _) = Text_
mkNodeTag SOFTBREAK = SoftBreak
mkNodeTag LINEBREAK = LineBreak
mkNodeTag (HTML_INLINE _) = HtmlInline
mkNodeTag (CUSTOM_INLINE _ _) = CustomInline
mkNodeTag (CODE _) = Code
mkNodeTag EMPH = Emphasis
mkNodeTag STRONG = Strong
mkNodeTag (LINK _ _) = Link
mkNodeTag (IMAGE _ _) = Image
mkNodeTag STRIKETHROUGH = StrikeThrough
mkNodeTag (TABLE _) = Table
mkNodeTag TABLE_ROW = TableRow
mkNodeTag TABLE_CELL = TableCell

hasNodeTag :: NodeTag -> NodeType -> Bool
hasNodeTag t t' = t == mkNodeTag t'