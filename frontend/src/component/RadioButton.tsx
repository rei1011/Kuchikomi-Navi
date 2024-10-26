import FormControl from "@mui/material/FormControl";
import FormControlLabel from "@mui/material/FormControlLabel";
import FormLabel from "@mui/material/FormLabel";
import Radio from "@mui/material/Radio";
import RadioGroup from "@mui/material/RadioGroup";

type Props = {
  label?: string;
  defaultValue?: string;
  options: {
    value: string;
    label: string;
  }[];
};

export const RadioButton = (props: Props) => {
  const { label, defaultValue, options } = props;
  return (
    <FormControl>
      <FormLabel id="radio-buttons-group">{label}</FormLabel>
      <RadioGroup
        aria-labelledby="radio-buttons-group"
        defaultValue={defaultValue}
        name="radio-buttons-group"
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
