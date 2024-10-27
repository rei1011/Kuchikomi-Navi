import FormControl from "@mui/material/FormControl";
import FormControlLabel from "@mui/material/FormControlLabel";
import FormLabel from "@mui/material/FormLabel";
import Radio from "@mui/material/Radio";
import RadioGroup from "@mui/material/RadioGroup";

type Props = {
  label?: string;
  defaultValue?: string;
  selectedValue?: string;
  onChange?: (event: React.ChangeEvent<HTMLInputElement>) => void;
  options: RadioButtonOptions;
};

export type RadioButtonOptions = { value: string; label: string }[];

export const RadioButtonGroup = (props: Props) => {
  const { label, defaultValue, options, selectedValue, onChange } = props;
  return (
    <FormControl>
      <FormLabel id="radio-buttons-group">{label}</FormLabel>
      <RadioGroup
        aria-labelledby="radio-buttons-group"
        defaultValue={defaultValue}
        name="radio-buttons-group"
        value={selectedValue}
        onChange={onChange}
      >
        {options.map((option) => {
          const { value, label } = option;
          return (
            <FormControlLabel
              key={value}
              value={value}
              label={label}
              control={<Radio />}
            />
          );
        })}
      </RadioGroup>
    </FormControl>
  );
};
